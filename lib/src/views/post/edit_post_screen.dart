import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likeminds_feed/likeminds_feed.dart';
import 'package:likeminds_feed_nova_fl/likeminds_feed_nova_fl.dart';
import 'package:likeminds_feed_nova_fl/src/blocs/new_post/new_post_bloc.dart';
import 'package:likeminds_feed_nova_fl/src/services/likeminds_service.dart';
import 'package:likeminds_feed_nova_fl/src/utils/constants/assets_constants.dart';
import 'package:likeminds_feed_nova_fl/src/utils/constants/ui_constants.dart';
import 'package:likeminds_feed_nova_fl/src/utils/local_preference/user_local_preference.dart';
import 'package:likeminds_feed_nova_fl/src/utils/post/post_utils.dart';
import 'package:likeminds_feed_nova_fl/src/utils/tagging/tagging_textfield_ta.dart';
import 'package:likeminds_feed_nova_fl/src/views/post/post_composer_header.dart';
import 'package:likeminds_feed_ui_fl/likeminds_feed_ui_fl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

class EditPostScreen extends StatefulWidget {
  static const String route = '/edit_post_screen';
  final String postId;
  const EditPostScreen({
    super.key,
    required this.postId,
  });

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  late Future<GetPostResponse> postFuture;
  final FocusNode _focusNode = FocusNode();
  TextEditingController? textEditingController;
  ValueNotifier<bool> rebuildAttachments = ValueNotifier(false);
  late String postId;
  Post? postDetails;
  NewPostBloc? newPostBloc;
  List<Attachment>? attachments;
  User? user;
  bool isDocumentPost = false; // flag for document or media post
  bool isMediaPost = false;
  String previewLink = '';
  String convertedPostText = '';
  MediaModel? linkModel;
  List<UserTag> userTags = [];
  bool showLinkPreview =
      true; // if set to false link preview should not be displayed
  Timer? _debounce;
  Size? screenSize;
  ThemeData? theme;

  void _onTextChanged(String p0) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      handleTextLinks(p0);
    });
  }

  Widget getPostDocument(double width) {
    return ListView.builder(
      itemCount: attachments!.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => LMDocument(
        size:
            getFileSizeString(bytes: attachments![index].attachmentMeta.size!),
        showBorder: false,
        type: attachments![index].attachmentMeta.format!,
        backgroundColor: theme!.colorScheme.surface,
        documentIcon: const LMIcon(
          type: LMIconType.svg,
          assetPath: kAssetPDFIcon,
          size: 20,
        ),
        documentUrl: attachments![index].attachmentMeta.url,
        onTap: () {
          Uri fileUrl = Uri.parse(attachments![index].attachmentMeta.url!);
          launchUrl(fileUrl, mode: LaunchMode.platformDefault);
        },
      ),
    );
  }

  void handleTextLinks(String text) async {
    String link = getFirstValidLinkFromString(text);
    if (link.isNotEmpty && showLinkPreview) {
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
      }
      rebuildAttachments.value = !rebuildAttachments.value;
    } else if (link.isEmpty) {
      linkModel = null;
      attachments?.removeWhere((element) => element.attachmentType == 4);
      rebuildAttachments.value = !rebuildAttachments.value;
    }
  }

  @override
  void initState() {
    super.initState();
    user = UserLocalPreference.instance.fetchUserData();
    postId = widget.postId;
    textEditingController = TextEditingController();
    postFuture = locator<LikeMindsService>().getPost((GetPostRequestBuilder()
          ..postId(widget.postId)
          ..page(1)
          ..pageSize(10))
        .build());
    if (_focusNode.canRequestFocus) {
      _focusNode.requestFocus();
    }
  }

  void checkTextLinks() {
    String link = getFirstValidLinkFromString(textEditingController!.text);
    if (link.isEmpty) {
      linkModel = null;
      attachments?.removeWhere((element) => element.attachmentType == 4);
    } else if (linkModel != null &&
        showLinkPreview &&
        !isDocumentPost &&
        !isMediaPost) {
      attachments = [
        Attachment(
          attachmentType: 4,
          attachmentMeta: AttachmentMeta(
            url: linkModel?.link,
            ogTags: AttachmentMetaOgTags(
              description: linkModel?.ogTags?.description,
              image: linkModel?.ogTags?.image,
              title: linkModel?.ogTags?.title,
              url: linkModel?.ogTags?.url,
            ),
          ),
        ),
      ];
    } else if (!showLinkPreview) {
      attachments?.removeWhere((element) => element.attachmentType == 4);
    }
  }

  void setPostData(Post post) {
    if (postDetails == null) {
      postDetails = post;
      convertedPostText = TaggingHelper.convertRouteToTag(post.text);
      textEditingController!.value = TextEditingValue(text: convertedPostText);
      textEditingController!.selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController!.text.length));
      userTags = TaggingHelper.addUserTagsIfMatched(post.text);
      attachments = post.attachments ?? [];
      if (attachments != null && attachments!.isNotEmpty) {
        if (attachments![0].attachmentType == 1 ||
            attachments![0].attachmentType == 2) {
          isMediaPost = true;
          showLinkPreview = false;
        } else if (attachments![0].attachmentType == 3) {
          isDocumentPost = true;
          showLinkPreview = false;
        } else if (attachments![0].attachmentType == 4) {
          linkModel = MediaModel(
              mediaType: MediaType.link,
              link: attachments![0].attachmentMeta.url,
              ogTags: attachments![0].attachmentMeta.ogTags);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    screenSize = MediaQuery.of(context).size;
    newPostBloc = BlocProvider.of<NewPostBloc>(context);
    theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () {
        if (textEditingController!.text != convertedPostText) {
          showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                    shadowColor: Colors.transparent,
                    backgroundColor: theme!.colorScheme.background,
                    elevation: 0,
                    content: LMTextView(
                      text: 'Are you sure you want to discard your changes?',
                      maxLines: 3,
                      textStyle: theme!.textTheme.labelLarge,
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
                                textStyle: theme!.textTheme.headlineMedium,
                              ),
                              onTap: () {
                                Navigator.of(dialogContext).pop();
                              },
                            ),
                            kHorizontalPaddingLarge,
                            LMTextButton(
                              text: LMTextView(
                                text: 'Discard',
                                textStyle: theme!.textTheme.headlineMedium!
                                    .copyWith(color: theme!.colorScheme.error),
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
                  ));
        } else {
          Navigator.of(context).pop();
        }
        return Future(() => false);
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: theme!.colorScheme.background,
          body: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: theme!.colorScheme.background,
              body: FutureBuilder(
                  future: postFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      GetPostResponse response = snapshot.data!;
                      if (response.success) {
                        setPostData(response.post!);
                        return postEditWidget();
                      } else {
                        return postErrorScreen(response.errorMessage!);
                      }
                    }
                    return const SizedBox();
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Widget postErrorScreen(String error) {
    return Center(
      child: Text(error),
    );
  }

  Widget postEditWidget() {
    return Stack(
      children: [
        Column(
          children: <Widget>[
            PostComposerHeader(
              onPressedBack: () {
                if (textEditingController!.text != convertedPostText) {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      shadowColor: Colors.transparent,
                      backgroundColor: theme!.colorScheme.background,
                      elevation: 0,
                      content: LMTextView(
                        text: 'Are you sure you want to discard your changes?',
                        maxLines: 3,
                        textStyle: theme!.textTheme.labelLarge,
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
                                  textStyle: theme!.textTheme.headlineMedium,
                                ),
                                onTap: () {
                                  Navigator.of(dialogContext).pop();
                                },
                              ),
                              kHorizontalPaddingLarge,
                              LMTextButton(
                                text: LMTextView(
                                  text: 'Discard',
                                  textStyle: theme!.textTheme.headlineMedium!
                                      .copyWith(
                                          color: theme!.colorScheme.error),
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
                } else {
                  Navigator.of(context).pop();
                }
              },
              title: const LMTextView(
                text: "",
              ),
              actionText: LMTextView(
                text: "Update",
                textStyle: theme!.textTheme.bodyMedium,
              ),
              onTap: () async {
                if (textEditingController!.text.isNotEmpty ||
                    (postDetails!.attachments != null &&
                        postDetails!.attachments!.isNotEmpty)) {
                  checkTextLinks();
                  userTags = TaggingHelper.matchTags(
                      textEditingController!.text, userTags);
                  String result = TaggingHelper.encodeString(
                      textEditingController!.text, userTags);
                  newPostBloc?.add(
                    EditPost(
                      postText: result,
                      attachments: attachments,
                      postId: postId,
                      selectedTopics: [],
                    ),
                  );
                  Navigator.of(context).pop();
                } else {
                  toast(
                    "Can't save a post without text or attachments",
                    duration: Toast.LENGTH_LONG,
                  );
                }
              },
            ),
            kVerticalPaddingMedium,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 6.0,
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
                          fallbackText: user!.name,
                          imageUrl: user!.imageUrl,
                          onTap: () {
                            if (user!.sdkClientInfo != null) {
                              locator<LikeMindsService>().routeToProfile(
                                  user!.sdkClientInfo!.userUniqueId);
                            }
                          },
                          size: 48,
                        ),
                        kHorizontalPaddingLarge,
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: LMTextView(
                              text: user!.name,
                              overflow: TextOverflow.ellipsis,
                              textStyle: theme!.textTheme.titleMedium,
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
                                  maxHeight: screenSize!.height * 0.8),
                              child: TaggingAheadTextField(
                                isDown: true,
                                minLines: 3,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'What\'s on your mind?',
                                  hintStyle: theme!.textTheme.labelMedium,
                                ),
                                onTagSelected: (tag) {
                                  userTags.add(tag);
                                },
                                controller: textEditingController!,
                                focusNode: _focusNode,
                                onChange: _onTextChanged,
                              ),
                            ),
                            kVerticalPaddingXLarge,
                            ValueListenableBuilder(
                                valueListenable: rebuildAttachments,
                                builder: (context, value, child) =>
                                    ((attachments != null &&
                                                    attachments!.isNotEmpty) &&
                                                mapIntToMediaType(attachments!
                                                        .first
                                                        .attachmentType) ==
                                                    MediaType.link &&
                                                showLinkPreview) ||
                                            (linkModel != null &&
                                                showLinkPreview)
                                        ? Stack(
                                            children: [
                                              LMLinkPreview(
                                                linkModel: linkModel,
                                                backgroundColor:
                                                    theme!.colorScheme.surface,
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
                                                border: const Border(),
                                                title: LMTextView(
                                                  text: linkModel
                                                          ?.ogTags?.title ??
                                                      "--",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textStyle: theme!
                                                      .textTheme.titleLarge,
                                                ),
                                                subtitle: LMTextView(
                                                  text: linkModel?.ogTags
                                                          ?.description ??
                                                      "--",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textStyle: theme!
                                                      .textTheme.displayLarge,
                                                ),
                                              ),
                                              Positioned(
                                                top: 5,
                                                right: 5,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showLinkPreview = false;
                                                    rebuildAttachments.value =
                                                        !rebuildAttachments
                                                            .value;
                                                  },
                                                  child:
                                                      const CloseButtonIcon(),
                                                ),
                                              )
                                            ],
                                          )
                                        : const SizedBox()),
                            if (attachments != null &&
                                attachments!.isNotEmpty &&
                                mapIntToMediaType(
                                        attachments!.first.attachmentType) !=
                                    MediaType.link)
                              mapIntToMediaType(
                                          attachments!.first.attachmentType) ==
                                      MediaType.document
                                  ? getPostDocument(screenSize!.width)
                                  : Builder(builder: (context) {
                                      int mediaLength = attachments!.length;
                                      return Container(
                                        padding: const EdgeInsets.only(
                                          top: kPaddingSmall,
                                        ),
                                        height: mediaLength == 1
                                            ? screenSize!.width - 32
                                            : 200,
                                        alignment: Alignment.center,
                                        child: ListView.builder(
                                          itemCount: mediaLength,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(
                                              children: [
                                                SizedBox(
                                                  child: Stack(
                                                    children: [
                                                      mapIntToMediaType(
                                                                  attachments![
                                                                          index]
                                                                      .attachmentType) ==
                                                              MediaType.video
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          20)),
                                                              child: Container(
                                                                height: mediaLength ==
                                                                        1
                                                                    ? screenSize!
                                                                            .width -
                                                                        32
                                                                    : 200,
                                                                width: mediaLength ==
                                                                        1
                                                                    ? screenSize!
                                                                            .width -
                                                                        32
                                                                    : 200,
                                                                color: Colors
                                                                    .black,
                                                                child: LMVideo(
                                                                  videoUrl: attachments![
                                                                          index]
                                                                      .attachmentMeta
                                                                      .url!,
                                                                  // height:
                                                                  //     180,
                                                                  boxFit: BoxFit
                                                                      .contain,
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
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          20)),
                                                              child: Container(
                                                                height: mediaLength ==
                                                                        1
                                                                    ? screenSize!
                                                                            .width -
                                                                        32
                                                                    : 200,
                                                                width: mediaLength ==
                                                                        1
                                                                    ? screenSize!
                                                                            .width -
                                                                        32
                                                                    : 200,
                                                                color: Colors
                                                                    .black,
                                                                child: LMImage(
                                                                  // height:
                                                                  //     180,
                                                                  // width:
                                                                  //     180,
                                                                  boxFit: BoxFit
                                                                      .contain,
                                                                  borderRadius:
                                                                      18,
                                                                  imageUrl: attachments![
                                                                          index]
                                                                      .attachmentMeta
                                                                      .url!,
                                                                ),
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                              ],
                                            );
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
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: 16.0,
          bottom: 16.0,
          child: LMIconButton(
            icon: LMIcon(
              type: LMIconType.svg,
              assetPath: kAssetMentionIcon,
              color: theme!.colorScheme.primary,
              boxPadding: 0,
              size: 28,
            ),
            onTap: (active) {
              if (!_focusNode.hasFocus) {
                _focusNode.requestFocus();
              }
              String currentText = textEditingController!.text;
              if (currentText.isNotEmpty) {
                currentText = '$currentText @';
              } else {
                currentText = '@';
              }
              textEditingController!.value =
                  TextEditingValue(text: currentText);
            },
          ),
        )
      ],
    );
  }
}
