import 'dart:async';
import 'dart:io';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:likeminds_feed/likeminds_feed.dart';
import 'package:likeminds_feed_nova_fl/src/blocs/new_post/new_post_bloc.dart';
import 'package:likeminds_feed_nova_fl/src/services/likeminds_service.dart';
import 'package:likeminds_feed_nova_fl/src/services/service_locator.dart';
import 'package:likeminds_feed_nova_fl/src/utils/analytics/analytics.dart';
import 'package:likeminds_feed_nova_fl/src/utils/constants/assets_constants.dart';
import 'package:likeminds_feed_nova_fl/src/utils/constants/ui_constants.dart';
import 'package:likeminds_feed_nova_fl/src/utils/local_preference/user_local_preference.dart';
import 'package:likeminds_feed_nova_fl/src/utils/post/post_media_picker.dart';
import 'package:likeminds_feed_nova_fl/src/utils/post/post_utils.dart';
import 'package:likeminds_feed_nova_fl/src/utils/tagging/tagging_textfield_ta.dart';
import 'package:likeminds_feed_nova_fl/src/views/post/post_composer_header.dart';
import 'package:likeminds_feed_nova_fl/src/widgets/topic/topic_popup.dart';

import 'package:likeminds_feed_ui_fl/likeminds_feed_ui_fl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class NewPostScreen extends StatefulWidget {
  final String? populatePostText;
  final List<MediaModel>? populatePostMedia;

  const NewPostScreen({
    super.key,
    this.populatePostText,
    this.populatePostMedia,
  });

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Future<GetTopicsResponse>? getTopicsResponse;
  ValueNotifier<bool> rebuildLinkPreview = ValueNotifier(false);
  List<TopicUI> selectedTopic = [];
  ValueNotifier<bool> rebuildTopicFloatingButton = ValueNotifier(false);
  final CustomPopupMenuController _controllerPopUp =
      CustomPopupMenuController();

  NewPostBloc? newPostBloc;
  late final User user;

  List<MediaModel> postMedia = [];
  List<UserTag> userTags = [];
  String? result;

  bool isDocumentPost = true; // flag for document or media post
  bool isMediaPost = true;
  bool isUploading = false;

  String previewLink = '';
  MediaModel? linkModel;
  bool showLinkPreview =
      true; // if set to false link preview should not be displayed
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    user = UserLocalPreference.instance.fetchUserData();
    getTopicsResponse =
        locator<LikeMindsService>().getTopics((GetTopicsRequestBuilder()
              ..page(1)
              ..pageSize(20)
              ..isEnabled(true))
            .build());
    newPostBloc = BlocProvider.of<NewPostBloc>(context);
    if (_focusNode.canRequestFocus) {
      _focusNode.requestFocus();
    }
  }

  /* 
  * Removes the media from the list
  * whenever the user taps on the X button
  */
  void removeAttachmenetAtIndex(int index) {
    if (postMedia.isNotEmpty) {
      postMedia.removeAt(index);
      if (postMedia.isEmpty) {
        isDocumentPost = true;
        isMediaPost = true;
        showLinkPreview = true;
      }
      setState(() {});
    }
  }

  // this function initiliases postMedia list
  // with photos/videos picked by the user
  void setPickedMediaFiles(List<MediaModel> pickedMediaFiles) {
    if (postMedia.isEmpty) {
      postMedia = <MediaModel>[...pickedMediaFiles];
    } else {
      postMedia.addAll(pickedMediaFiles);
    }
  }

  /* 
  * Changes state to uploading
  * for showing a circular loader while the user is
  * picking files 
  */
  void onUploading() {
    setState(() {
      isUploading = true;
    });
  }

  /* 
  * Changes state to uploaded
  * for showing the picked files 
  */
  void onUploadedMedia(bool uploadResponse) {
    if (uploadResponse) {
      isMediaPost = true;
      showLinkPreview = false;
      isDocumentPost = false;
      setState(() {
        isUploading = false;
      });
    } else {
      if (postMedia.isEmpty) {
        isMediaPost = true;
        showLinkPreview = true;
      }
      setState(() {
        isUploading = false;
      });
    }
  }

  void onUploadedDocument(bool uploadResponse) {
    if (uploadResponse) {
      isDocumentPost = true;
      showLinkPreview = false;
      isMediaPost = true;
      setState(() {
        isUploading = false;
      });
    } else {
      if (postMedia.isEmpty) {
        isDocumentPost = false;
        showLinkPreview = true;
      }
      setState(() {
        isUploading = false;
      });
    }
  }

  /*
  * This function return a list 
  * containing LMDocument widget
  * which generates preview for a document 
  */
  Widget getPostDocument(double width) {
    return ListView.builder(
      itemCount: postMedia.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => LMDocument(
        size: getFileSizeString(bytes: postMedia[index].size!),
        onTap: () {
          OpenFilex.open(postMedia[index].mediaFile!.path);
        },
        type: postMedia[index].format!,
        documentIcon: const LMIcon(
          type: LMIconType.svg,
          assetPath: kAssetDocPDFIcon,
          color: Colors.red,
          size: 45,
          boxPadding: 0,
        ),
        documentFile: postMedia[index].mediaFile,
        onRemove: () => removeAttachmenetAtIndex(index),
      ),
    );
  }

  /*
  * Takes a string as input
  * extracts the first valid link from the string
  * decodes the url using LikeMinds SDK
  * and generates a preview for the link
  */
  void handleTextLinks(String text) async {
    String link = getFirstValidLinkFromString(text);
    if (link.isNotEmpty) {
      previewLink = link;
      DecodeUrlRequest request =
          (DecodeUrlRequestBuilder()..url(previewLink)).build();
      DecodeUrlResponse response =
          await locator<LikeMindsService>().decodeUrl(request);
      if (response.success == true) {
        OgTags? responseTags = response.ogTags;
        linkModel = MediaModel(
          mediaType: MediaType.link,
          link: previewLink,
          ogTags: AttachmentMetaOgTags(
            description: responseTags!.description,
            image: responseTags.image,
            title: responseTags.title,
            url: responseTags.url,
          ),
        );
        LMAnalytics.get().track(
          AnalyticsKeys.linkAttachedInPost,
          {
            'link': previewLink,
          },
        );
        if (postMedia.isEmpty) {
          rebuildLinkPreview.value = !rebuildLinkPreview.value;
        }
      }
    } else if (link.isEmpty) {
      linkModel = null;
      rebuildLinkPreview.value = !rebuildLinkPreview.value;
    }
  }

  /* 
  * This function adds the link model in attachemnt
  * If the link model is not present in the attachment
  * and the link preview is enabled (no media is there)
  */
  void checkTextLinks() {
    String link = getFirstValidLinkFromString(_controller.text);
    if (link.isEmpty) {
      linkModel = null;
    } else if (linkModel != null && postMedia.isEmpty && showLinkPreview) {
      postMedia.add(linkModel!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    newPostBloc = BlocProvider.of<NewPostBloc>(context);
    Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Discard Post'),
            content: const Text(
                'Are you sure you want to discard the current post?'),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );

        return Future.value(false);
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: theme.colorScheme.background,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 64.0, left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: FutureBuilder<GetTopicsResponse>(
                    future: getTopicsResponse,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData &&
                          snapshot.data!.success == true) {
                        if (snapshot.data!.topics!.isNotEmpty) {
                          return ValueListenableBuilder(
                            valueListenable: rebuildTopicFloatingButton,
                            builder: (context, _, __) {
                              return GestureDetector(
                                onTap: () async {
                                  if (_focusNode.hasFocus) {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    currentFocus.unfocus();
                                    await Future.delayed(
                                        const Duration(milliseconds: 500));
                                  }
                                  _controllerPopUp.showMenu();
                                },
                                child: AbsorbPointer(
                                  absorbing: true,
                                  child: CustomPopupMenu(
                                    controller: _controllerPopUp,
                                    showArrow: false,
                                    verticalMargin: 10,
                                    horizontalMargin: 16.0,
                                    pressType: PressType.singleClick,
                                    menuBuilder: () => TopicPopUp(
                                      selectedTopics: selectedTopic,
                                      backgroundColor:
                                          theme.colorScheme.surface,
                                      selectedTextColor:
                                          theme.colorScheme.primaryContainer,
                                      unSelectedTextColor:
                                          theme.colorScheme.primaryContainer,
                                      selectedColor: theme.colorScheme.primary,
                                      isEnabled: true,
                                      onTopicSelected:
                                          (updatedTopics, tappedTopic) {
                                        if (selectedTopic.isEmpty) {
                                          selectedTopic.add(tappedTopic);
                                        } else {
                                          if (selectedTopic.first.id ==
                                              tappedTopic.id) {
                                            selectedTopic.clear();
                                          } else {
                                            selectedTopic.clear();
                                            selectedTopic.add(tappedTopic);
                                          }
                                        }
                                        _controllerPopUp.hideMenu();
                                        rebuildTopicFloatingButton.value =
                                            !rebuildTopicFloatingButton.value;
                                      },
                                    ),
                                    child: Container(
                                      height: 36,
                                      alignment: Alignment.bottomLeft,
                                      margin: const EdgeInsets.only(left: 16.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(500),
                                        color: theme.colorScheme.primary,
                                      ),
                                      child: LMTopicChip(
                                        topic: selectedTopic.isEmpty
                                            ? (TopicUIBuilder()
                                                  ..id("0")
                                                  ..isEnabled(true)
                                                  ..name("Topic"))
                                                .build()
                                            : selectedTopic.first,
                                        textStyle: theme.textTheme.bodyMedium,
                                        icon: LMIcon(
                                          type: LMIconType.icon,
                                          icon: CupertinoIcons.chevron_down,
                                          size: 16,
                                          color: theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                kVerticalPaddingMedium,
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 72.0,
                      bottom: 40.0,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LMProfilePicture(
                                fallbackText: user.name,
                                imageUrl: user.imageUrl,
                                onTap: () {
                                  if (user.sdkClientInfo != null) {
                                    locator<LikeMindsService>().routeToProfile(
                                        user.sdkClientInfo!.userUniqueId);
                                  }
                                },
                                size: 48,
                              ),
                              kHorizontalPaddingLarge,
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: LMTextView(
                                    text: user.name,
                                    overflow: TextOverflow.ellipsis,
                                    textStyle: theme.textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        kVerticalPaddingLarge,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(),
                                    constraints: BoxConstraints(
                                        maxHeight: screenSize.height * 0.8),
                                    child: TaggingAheadTextField(
                                      isDown: true,
                                      minLines: 3,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'What\'s on your mind?',
                                        hintStyle: theme.textTheme.labelMedium,
                                      ),
                                      onTagSelected: (tag) {
                                        userTags.add(tag);
                                      },
                                      controller: _controller,
                                      focusNode: _focusNode,
                                      onChange: _onTextChanged,
                                    ),
                                  ),
                                  kVerticalPaddingXLarge,
                                  if (isUploading)
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        top: kPaddingMedium,
                                        bottom: kPaddingLarge,
                                      ),
                                      child: LMLoader(),
                                    ),
                                  ValueListenableBuilder(
                                      valueListenable: rebuildLinkPreview,
                                      builder: (context, value, child) {
                                        return (postMedia.isEmpty &&
                                                linkModel != null &&
                                                showLinkPreview)
                                            ? Stack(
                                                children: [
                                                  LMLinkPreview(
                                                    linkModel: linkModel,
                                                    backgroundColor:
                                                        kSecondary100,
                                                    showLinkUrl: false,
                                                    onTap: () {
                                                      launchUrl(
                                                        Uri.parse(linkModel
                                                                ?.ogTags?.url ??
                                                            ''),
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    },
                                                    border: Border.all(
                                                      width: 1,
                                                      color: kSecondary100,
                                                    ),
                                                    title: LMTextView(
                                                      text: linkModel
                                                              ?.ogTags?.title ??
                                                          "--",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textStyle:
                                                          const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            kHeadingBlackColor,
                                                        height: 1.30,
                                                      ),
                                                    ),
                                                    subtitle: LMTextView(
                                                      text: linkModel?.ogTags
                                                              ?.description ??
                                                          "--",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textStyle:
                                                          const TextStyle(
                                                        color:
                                                            kHeadingBlackColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.30,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        showLinkPreview = false;
                                                        rebuildLinkPreview
                                                                .value =
                                                            !rebuildLinkPreview
                                                                .value;
                                                      },
                                                      child:
                                                          const CloseButtonIcon(),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : const SizedBox();
                                      }),
                                  if (postMedia.isNotEmpty)
                                    postMedia.first.mediaType ==
                                            MediaType.document
                                        ? getPostDocument(screenSize.width)
                                        : Builder(builder: (context) {
                                            int mediaLength = postMedia.length;
                                            return Container(
                                              padding: const EdgeInsets.only(
                                                top: kPaddingSmall,
                                              ),
                                              height: mediaLength == 1
                                                  ? screenSize.width - 32
                                                  : 200,
                                              alignment: Alignment.center,
                                              child: ListView.builder(
                                                itemCount: mediaLength,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Stack(children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          child: Stack(
                                                            children: [
                                                              postMedia[index]
                                                                          .mediaType ==
                                                                      MediaType
                                                                          .video
                                                                  ? ClipRRect(
                                                                      borderRadius: const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              20)),
                                                                      child:
                                                                          Container(
                                                                        height: mediaLength ==
                                                                                1
                                                                            ? screenSize.width -
                                                                                32
                                                                            : 200,
                                                                        width: mediaLength ==
                                                                                1
                                                                            ? screenSize.width -
                                                                                32
                                                                            : 200,
                                                                        color: Colors
                                                                            .black,
                                                                        child:
                                                                            LMVideo(
                                                                          videoFile:
                                                                              postMedia[index].mediaFile!,
                                                                          // height:
                                                                          //     180,
                                                                          boxFit:
                                                                              BoxFit.contain,
                                                                          showControls:
                                                                              false,
                                                                          // width:
                                                                          //     300,
                                                                          borderRadius:
                                                                              18,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : ClipRRect(
                                                                      borderRadius: const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              20)),
                                                                      child:
                                                                          Container(
                                                                        height: mediaLength ==
                                                                                1
                                                                            ? screenSize.width -
                                                                                32
                                                                            : 200,
                                                                        width: mediaLength ==
                                                                                1
                                                                            ? screenSize.width -
                                                                                32
                                                                            : 200,
                                                                        color: Colors
                                                                            .black,
                                                                        child:
                                                                            LMImage(
                                                                          // height:
                                                                          //     180,
                                                                          // width:
                                                                          //     180,
                                                                          boxFit:
                                                                              BoxFit.contain,
                                                                          borderRadius:
                                                                              18,
                                                                          imageFile:
                                                                              postMedia[index].mediaFile!,
                                                                        ),
                                                                      ),
                                                                    ),
                                                              Positioned(
                                                                top: 4,
                                                                right: 4,
                                                                child:
                                                                    LMIconButton(
                                                                  onTap: (active) =>
                                                                      removeAttachmenetAtIndex(
                                                                          index),
                                                                  icon: LMIcon(
                                                                    type: LMIconType
                                                                        .icon,
                                                                    icon: CupertinoIcons
                                                                        .xmark_circle_fill,
                                                                    backgroundColor: theme
                                                                        .colorScheme
                                                                        .background
                                                                        .withOpacity(
                                                                            0.5),
                                                                    color: theme
                                                                        .colorScheme
                                                                        .onPrimary,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                      ],
                                                    ),
                                                  ]);
                                                },
                                              ),
                                            );
                                          }),
                                  kVerticalPaddingMedium,
                                ],
                              ),
                            ),
                          ],
                        ),
                        kVerticalPaddingXLarge,
                        const SizedBox(height: 55),
                      ],
                    ),
                  ),
                ),
                // const Spacer(),
                PostComposerHeader(
                  onPressedBack: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        content: LMTextView(
                          text:
                              'Are you sure you want to discard your changes?',
                          maxLines: 3,
                          textStyle: theme.textTheme.labelLarge,
                        ),
                        actions: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 4.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                LMTextButton(
                                  text: LMTextView(
                                    text: 'No thanks',
                                    textStyle: theme.textTheme.headlineMedium,
                                  ),
                                  onTap: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                ),
                                kHorizontalPaddingLarge,
                                LMTextButton(
                                  text: LMTextView(
                                    text: 'Discard',
                                    textStyle: theme.textTheme.headlineMedium!
                                        .copyWith(
                                            color: theme.colorScheme.error),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 4.0),
                                  onTap: () {
                                    Navigator.of(dialogContext).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  title: const LMTextView(text: ''),
                  onTap: () {
                    _focusNode.unfocus();

                    String postText = _controller.text;
                    postText = postText.trim();
                    if (postText.isNotEmpty || postMedia.isNotEmpty) {
                      if (selectedTopic.isEmpty) {
                        toast(
                          "Can't create a post without topic",
                          duration: Toast.LENGTH_LONG,
                        );
                        return;
                      }
                      checkTextLinks();
                      userTags =
                          TaggingHelper.matchTags(_controller.text, userTags);

                      result = TaggingHelper.encodeString(
                          _controller.text, userTags);
                      newPostBloc!.add(
                        CreateNewPost(
                          postText: result!,
                          postMedia: postMedia,
                          selectedTopics: selectedTopic,
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      toast(
                        "Can't create a post without text or attachments",
                        duration: Toast.LENGTH_LONG,
                      );
                    }
                  },
                ),

                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    // height: 32,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.background,
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: isMediaPost ? 1 : 0.5,
                          child: LMIconButton(
                            icon: LMIcon(
                              type: LMIconType.svg,
                              assetPath: kAssetGalleryIcon,
                              color: theme.colorScheme.primary,
                              boxPadding: 0,
                              size: 28,
                            ),
                            onTap: isMediaPost
                                ? (active) async {
                                    LMAnalytics.get().track(
                                        AnalyticsKeys.clickedOnAttachment,
                                        {'type': 'image'});
                                    final result =
                                        await handlePermissions(context, 1);
                                    if (result) {
                                      pickImages();
                                    }
                                  }
                                : (active) {},
                          ),
                        ),
                        // isMediaPost
                        //     ? const SizedBox(width: 8)
                        //     : const SizedBox.shrink(),
                        // isMediaPost
                        //     ? LMIconButton(
                        //         icon: LMIcon(
                        //           type: LMIconType.svg,
                        //           assetPath: kAssetVideoIcon,
                        //           color:
                        //               Theme.of(context).colorScheme.primary,
                        //           boxPadding: 0,
                        //           size: 44,
                        //         ),
                        //         onTap: (active) async {
                        //           onUploading();
                        //           List<MediaModel>? pickedMediaFiles =
                        //               await PostMediaPicker.pickVideos(
                        //                   postMedia.length);
                        //           if (pickedMediaFiles != null) {
                        //             setPickedMediaFiles(pickedMediaFiles);
                        //             onUploadedMedia(true);
                        //           } else {
                        //             onUploadedMedia(false);
                        //           }
                        //         },
                        //       )
                        //     : const SizedBox.shrink(),
                        const SizedBox(width: 16.0),
                        Opacity(
                          opacity: isDocumentPost ? 1 : 0.5,
                          child: LMIconButton(
                            icon: LMIcon(
                              type: LMIconType.svg,
                              assetPath: kAssetDocPDFIcon,
                              color: theme.colorScheme.primary,
                              boxPadding: 0,
                              size: 28,
                            ),
                            onTap: isDocumentPost
                                ? (active) async {
                                    if (postMedia.length >= 3) {
                                      //  TODO: Add your own toast message for document limit
                                      return;
                                    }
                                    onUploading();
                                    LMAnalytics.get().track(
                                        AnalyticsKeys.clickedOnAttachment,
                                        {'type': 'file'});
                                    List<MediaModel>? pickedMediaFiles =
                                        await PostMediaPicker.pickDocuments(
                                            postMedia.length);
                                    if (pickedMediaFiles != null) {
                                      setPickedMediaFiles(pickedMediaFiles);
                                      onUploadedDocument(true);
                                    } else {
                                      onUploadedDocument(false);
                                    }
                                  }
                                : (active) {},
                          ),
                        ),

                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTextChanged(String p0) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      handleTextLinks(p0);
    });
  }

  Future<bool> handlePermissions(BuildContext context, int mediaType) async {
    if (Platform.isAndroid) {
      PermissionStatus permissionStatus;

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        if (mediaType == 1) {
          permissionStatus = await Permission.photos.status;
          if (permissionStatus == PermissionStatus.granted) {
            return true;
          } else if (permissionStatus == PermissionStatus.denied) {
            permissionStatus = await Permission.photos.request();
            if (permissionStatus == PermissionStatus.permanentlyDenied) {
              toast(
                'Permissions denied, change app settings',
                duration: Toast.LENGTH_LONG,
              );
              return false;
            } else if (permissionStatus == PermissionStatus.granted) {
              return true;
            } else {
              return false;
            }
          }
        } else {
          permissionStatus = await Permission.videos.status;
          if (permissionStatus == PermissionStatus.granted) {
            return true;
          } else if (permissionStatus == PermissionStatus.denied) {
            permissionStatus = await Permission.videos.request();
            if (permissionStatus == PermissionStatus.permanentlyDenied) {
              toast(
                'Permissions denied, change app settings',
                duration: Toast.LENGTH_LONG,
              );
              return false;
            } else if (permissionStatus == PermissionStatus.granted) {
              return true;
            } else {
              return false;
            }
          }
        }
      } else {
        permissionStatus = await Permission.storage.status;
        if (permissionStatus == PermissionStatus.granted) {
          return true;
        } else {
          permissionStatus = await Permission.storage.request();
          if (permissionStatus == PermissionStatus.granted) {
            return true;
          } else if (permissionStatus == PermissionStatus.denied) {
            return false;
          } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
            toast(
              'Permissions denied, change app settings',
              duration: Toast.LENGTH_LONG,
            );
            return false;
          }
        }
      }
    }
    return true;
  }

  void pickImages() async {
    onUploading();
    try {
      final FilePickerResult? list = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );
      final config =
          await UserLocalPreference.instance.getCommunityConfigurations();
      final sizeLimit = config.value!["max_image_size"]! / 1024;
      if (list != null && list.files.isNotEmpty) {
        if (postMedia.length + list.files.length > 10) {
          toast(
            'A total of 10 attachments can be added to a post',
            duration: Toast.LENGTH_LONG,
          );
          onUploadedMedia(false);
          return;
        }
        for (PlatformFile image in list.files) {
          int fileBytes = image.size;
          double fileSize = getFileSizeInDouble(fileBytes);
          if (fileSize > sizeLimit) {
            toast(
              'Max file size allowed: ${sizeLimit}MB',
              duration: Toast.LENGTH_LONG,
            );
            onUploadedMedia(false);
            return;
          }
        }
        List<File> pickedFiles = list.files.map((e) => File(e.path!)).toList();
        List<MediaModel> mediaFiles = pickedFiles
            .map((e) =>
                MediaModel(mediaFile: File(e.path), mediaType: MediaType.image))
            .toList();
        setPickedMediaFiles(mediaFiles);
        onUploadedMedia(true);

        return;
      } else {
        onUploadedMedia(false);
        return;
      }
    } catch (e) {
      toast(
        'An error occurred',
        duration: Toast.LENGTH_LONG,
      );
      onUploadedMedia(false);
      print(e.toString());
      return;
    }
  }

  void pickVideos(BuildContext context) async {}
}
