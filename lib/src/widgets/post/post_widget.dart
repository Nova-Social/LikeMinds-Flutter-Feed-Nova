import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likeminds_feed/likeminds_feed.dart';
import 'package:likeminds_feed_nova_fl/likeminds_feed_nova_fl.dart';
import 'package:likeminds_feed_nova_fl/src/blocs/new_post/new_post_bloc.dart';
import 'package:likeminds_feed_nova_fl/src/models/post_view_model.dart';
import 'package:likeminds_feed_nova_fl/src/services/likeminds_service.dart';
import 'package:likeminds_feed_nova_fl/src/utils/constants/assets_constants.dart';
import 'package:likeminds_feed_nova_fl/src/utils/constants/ui_constants.dart';
import 'package:likeminds_feed_nova_fl/src/utils/post/post_action_id.dart';
import 'package:likeminds_feed_nova_fl/src/utils/post/post_utils.dart';
import 'package:likeminds_feed_nova_fl/src/views/likes/likes_screen.dart';
import 'package:likeminds_feed_nova_fl/src/views/media_preview.dart';
import 'package:likeminds_feed_nova_fl/src/views/post/edit_post_screen.dart';
import 'package:likeminds_feed_nova_fl/src/views/post_detail_screen.dart';
import 'package:likeminds_feed_nova_fl/src/widgets/delete_dialog.dart';
import 'package:likeminds_feed_nova_fl/src/widgets/topic/topic_chip_widget.dart';
import 'package:likeminds_feed_ui_fl/likeminds_feed_ui_fl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class SSPostWidget extends StatefulWidget {
  final PostViewModel post;
  final User user;
  final Map<String, Topic> topics;
  final bool isFeed;
  final Function() onTap;
  final Function(bool isDeleted) refresh;

  const SSPostWidget({
    Key? key,
    required this.post,
    required this.user,
    required this.onTap,
    required this.topics,
    required this.refresh,
    required this.isFeed,
  }) : super(key: key);

  @override
  State<SSPostWidget> createState() => _SSPostWidgetState();
}

class _SSPostWidgetState extends State<SSPostWidget> {
  int postLikes = 0;
  int comments = 0;
  PostViewModel? postDetails;
  bool? isLiked;
  bool? isPinned;
  ValueNotifier<bool> rebuildLikeWidget = ValueNotifier(false);
  ValueNotifier<bool> rebuildPostWidget = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    setPostDetails();
  }

  @override
  void didUpdateWidget(covariant SSPostWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setPostDetails();
  }

  removeEditPost() {
    postDetails!.menuItems.removeWhere((element) {
      return element.id == postEditId;
    });
  }

  void setPostDetails() {
    postDetails = widget.post;
    postLikes = postDetails!.likeCount;
    comments = postDetails!.commentCount;
    isLiked = postDetails!.isLiked;
    isPinned = postDetails!.isPinned;
    removeEditPost();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    NewPostBloc newPostBloc = BlocProvider.of<NewPostBloc>(context);
    timeago.setLocaleMessages('en', SSCustomMessages());
    ThemeData theme = Theme.of(context);
    return InheritedPostProvider(
      post: widget.post.toPost(),
      child: Container(
        color: theme.colorScheme.background,
        child: BlocListener(
          bloc: newPostBloc,
          listener: (context, state) {
            if (state is PostPinnedState && state.postId == widget.post.id) {
              isPinned = state.isPinned;
              int? itemIndex = postDetails?.menuItems.indexWhere((element) {
                return (isPinned! && element.id == 2) ||
                    (!isPinned! && element.id == 3);
              });
              if (itemIndex != null && itemIndex != -1) {
                if (postDetails!.menuItems[itemIndex].id == 2) {
                  postDetails!.menuItems[itemIndex] =
                      PopupMenuItemModel(title: "Unpin this Post", id: 3);
                } else if (postDetails!.menuItems[itemIndex].id == 3) {
                  postDetails!.menuItems[itemIndex] =
                      PopupMenuItemModel(title: "Pin this Post", id: 2);
                }
              }
              postDetails!.isPinned = isPinned!;
              rebuildPostWidget.value = !rebuildPostWidget.value;
              newPostBloc.add(UpdatePost(post: postDetails!));
            } else if (state is PostPinError &&
                state.postId == widget.post.id) {
              isPinned = state.isPinned;
              rebuildPostWidget.value = !rebuildPostWidget.value;
            }
          },
          child: GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () {
              // Navigate to LMPostPage using material route
              if (widget.isFeed) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PostDetailScreen(
                      postId: widget.post.id,
                    ),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: rebuildPostWidget,
                    builder: (context, _, __) => isPinned!
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  LMIcon(
                                    type: LMIconType.svg,
                                    assetPath: kAssetPinIcon,
                                    color: theme.colorScheme.onPrimary,
                                    size: 20,
                                  ),
                                  kHorizontalPaddingMedium,
                                  LMTextView(
                                    text: "Pinned Post",
                                    textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  )
                                ],
                              ),
                              kVerticalPaddingMedium,
                            ],
                          )
                        : const SizedBox(),
                  ),
                  ValueListenableBuilder(
                      valueListenable: rebuildPostWidget,
                      builder: (context, _, __) {
                        return LMPostHeader(
                          user: widget.user,
                          isFeed: widget.isFeed,
                          customTitle: LMTextView(
                            text: widget.user.customTitle!.isNotEmpty
                                ? widget.user.customTitle!
                                : "",
                            // maxLines: 1,
                            textStyle: theme.textTheme.titleSmall,
                          ),
                          fallbackTextStyle: theme.textTheme.titleLarge!
                              .copyWith(fontSize: 28),
                          imageSize: 52,
                          onProfileTap: () {
                            if (widget.user.sdkClientInfo != null) {
                              locator<LikeMindsService>().routeToProfile(
                                  widget.user.sdkClientInfo!.userUniqueId);
                            }
                          },
                          titleText: LMTextView(
                            text: widget.user.name,
                            textStyle: theme.textTheme.titleLarge,
                          ),
                          subText: LMTextView(
                            text:
                                "@${widget.user.name.toLowerCase().split(" ").join("")}",
                            textStyle: theme.textTheme.labelMedium,
                          ),
                          createdAt: LMTextView(
                            text: timeago.format(widget.post.createdAt),
                            textStyle: theme.textTheme.labelMedium,
                          ),
                          menu: LMPostMenu(
                            menuItems: postDetails!.menuItems,
                            onSelected: (id) {
                              if (id == postDeleteId) {
                                // Delete post
                                showDialog(
                                    context: context,
                                    builder: (childContext) =>
                                        deleteConfirmationDialog(
                                          childContext,
                                          title: 'Delete Post',
                                          userId: postDetails!.userId,
                                          content:
                                              'Are you sure you want to delete this post. This action can not be reversed.',
                                          action: (String reason) async {
                                            Navigator.of(childContext).pop();
                                            final res = await locator<
                                                    LikeMindsService>()
                                                .getMemberState();
                                            //Implement delete post analytics tracking
                                            LMAnalytics.get().track(
                                              AnalyticsKeys.postDeleted,
                                              {
                                                "user_state": res.state == 1
                                                    ? "CM"
                                                    : "member",
                                                "post_id": postDetails!.id,
                                                "user_id": postDetails!.userId,
                                              },
                                            );
                                            newPostBloc.add(
                                              DeletePost(
                                                postId: postDetails!.id,
                                                reason: reason ?? 'Self Post',
                                              ),
                                            );
                                            if (!widget.isFeed) {
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          actionText: 'Delete',
                                        ));
                              } else if (id == postPinId || id == postUnpinId) {
                                String? postType = getPostType(postDetails!
                                        .attachments?.first.attachmentType ??
                                    0);
                                if (isPinned!) {
                                  LMAnalytics.get()
                                      .track(AnalyticsKeys.postUnpinned, {
                                    "created_by_id": postDetails!.userId,
                                    "post_id": postDetails!.id,
                                    "post_type": postType,
                                  });
                                } else {
                                  LMAnalytics.get()
                                      .track(AnalyticsKeys.postPinned, {
                                    "created_by_id": postDetails!.userId,
                                    "post_id": postDetails!.id,
                                    "post_type": postType,
                                  });
                                }
                                newPostBloc.add(TogglePinPost(
                                    postId: postDetails!.id,
                                    isPinned: !isPinned!));
                              } else if (id == postEditId) {
                                String? postType;
                                postType = getPostType(postDetails!
                                        .attachments?.first.attachmentType ??
                                    0);
                                LMAnalytics.get()
                                    .track(AnalyticsKeys.postEdited, {
                                  "created_by_id": postDetails!.userId,
                                  "post_id": postDetails!.id,
                                  "post_type": postType,
                                });
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditPostScreen(
                                      postId: postDetails!.id,
                                    ),
                                  ),
                                );
                              }
                            },
                            isFeed: widget.isFeed,
                          ),
                        );
                      }),
                  const SizedBox(height: 16),
                  // postDetails!.topics.isEmpty ||
                  //         widget.topics[postDetails!.topics.first] == null
                  //     ? const SizedBox()
                  //     : Padding(
                  //         padding: const EdgeInsets.only(bottom: 12.0),
                  //         child: TopicChipWidget(
                  //           postTopic: TopicUI.fromTopic(
                  //               widget.topics[postDetails!.topics.first]!),
                  //         ),
                  //       ),
                  LMPostContent(
                    onTagTap: (String userId) {
                      locator<LikeMindsService>().routeToProfile(userId);
                    },
                    textStyle: theme.textTheme.bodyMedium,
                  ),
                  postDetails!.attachments != null &&
                          postDetails!.text.isNotEmpty
                      ? const SizedBox(height: 16)
                      : const SizedBox(),
                  postDetails!.attachments != null &&
                          postDetails!.attachments!.isNotEmpty
                      ? postDetails!.attachments!.first.attachmentType == 4
                          ? LMLinkPreview(
                              attachment: postDetails!.attachments![0],
                              backgroundColor: ColorTheme.backgroundColor,
                              showLinkUrl: false,
                              onTap: () {
                                if (postDetails!.attachments!.first
                                        .attachmentMeta.url !=
                                    null) {
                                  launchUrl(
                                    Uri.parse(postDetails!.attachments!.first
                                        .attachmentMeta.url!),
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              border: Border.all(
                                width: 1,
                                color: kSecondary100,
                              ),
                              title: LMTextView(
                                text: postDetails!.attachments!.first
                                        .attachmentMeta.ogTags?.title ??
                                    "--",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kWhiteColor,
                                  height: 1.30,
                                ),
                              ),
                              subtitle: LMTextView(
                                text: postDetails!.attachments!.first
                                        .attachmentMeta.ogTags?.description ??
                                    "--",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textStyle: const TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w400,
                                  height: 1.30,
                                ),
                              ),
                            )
                          : SizedBox(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return MediaPreview(
                                        postAttachments:
                                            postDetails!.attachments!,
                                        post: postDetails!.toPost(),
                                        user: widget.user,
                                      );
                                    }),
                                  );
                                },
                                child: LMPostMedia(
                                  attachments: postDetails!.attachments!,
                                  borderRadius: 16.0,
                                  showLinkUrl: false,
                                  backgroundColor: kSecondary100,
                                  carouselActiveIndicatorColor:
                                      theme.colorScheme.primary,
                                  carouselInactiveIndicatorColor: theme
                                      .colorScheme.primary
                                      .withOpacity(0.3),
                                  documentIcon: const LMIcon(
                                    type: LMIconType.svg,
                                    assetPath: kAssetDocPDFIcon,
                                    size: 50,
                                    boxPadding: 0,
                                    fit: BoxFit.cover,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                      : const SizedBox(),
                  kVerticalPaddingLarge,
                  LMPostFooter(
                    alignment: LMAlignment.left,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: rebuildLikeWidget,
                          builder: (context, _, __) {
                            return LMTextButton(
                              text: LMTextView(
                                text: "$postLikes",
                                textStyle: theme.textTheme.labelMedium,
                              ),
                              margin: 0,
                              onTap: () async {
                                if (isLiked!) {
                                  postLikes--;
                                  postDetails!.likeCount -= 1;
                                  postDetails!.isLiked = false;
                                } else {
                                  postLikes++;
                                  postDetails!.likeCount += 1;
                                  postDetails!.isLiked = true;
                                }
                                isLiked = !isLiked!;
                                rebuildLikeWidget.value =
                                    !rebuildLikeWidget.value;

                                final response =
                                    await locator<LikeMindsService>().likePost(
                                        (LikePostRequestBuilder()
                                              ..postId(postDetails!.id))
                                            .build());
                                if (!response.success) {
                                  toast(
                                    response.errorMessage ??
                                        "There was an error liking the post",
                                    duration: Toast.LENGTH_LONG,
                                  );

                                  if (isLiked!) {
                                    postLikes--;
                                    postDetails!.likeCount -= 1;
                                    postDetails!.isLiked = false;
                                  } else {
                                    postLikes++;
                                    postDetails!.likeCount += 1;
                                    postDetails!.isLiked = true;
                                  }
                                  isLiked = !isLiked!;
                                  rebuildLikeWidget.value =
                                      !rebuildLikeWidget.value;
                                } else {
                                  if (!widget.isFeed) {
                                    newPostBloc.add(
                                      UpdatePost(
                                        post: postDetails!,
                                      ),
                                    );
                                  }
                                }
                              },
                              icon: LMIcon(
                                type: LMIconType.svg,
                                assetPath: kAssetLikeIcon,
                                color: theme.colorScheme.onPrimary,
                                size: 20,
                                boxPadding: 6,
                              ),
                              activeIcon: LMIcon(
                                type: LMIconType.svg,
                                assetPath: kAssetLikeFilledIcon,
                                color: theme.colorScheme.error,
                                size: 20,
                                boxPadding: 6,
                              ),
                              isActive: isLiked!,
                            );
                          }),
                      kHorizontalPaddingMedium,
                      LMTextButton(
                        text: LMTextView(
                          text: "$comments",
                          textStyle: theme.textTheme.labelMedium,
                        ),
                        margin: 0,
                        onTap: () {
                          if (widget.isFeed) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailScreen(
                                  postId: widget.post.id,
                                  fromCommentButton: true,
                                ),
                              ),
                            );
                          }
                        },
                        icon: LMIcon(
                          type: LMIconType.svg,
                          assetPath: kAssetCommentIcon,
                          color: theme.colorScheme.onPrimary,
                          size: 20,
                          boxPadding: 6,
                        ),
                      ),

                      // LMTextButton(
                      //   text: const LMTextView(text: "Share"),
                      //   margin: 0,
                      //   onTap: () {
                      //     SharePost().sharePost(widget.post.id);
                      //   },
                      //   icon: LMIcon(
                      //     type: LMIconType.svg,
                      //     assetPath: kAssetShareIcon,
                      //     color: Theme.of(context).colorScheme.onSecondary,
                      //     size: 20,
                      //     boxPadding: 6,
                      //   ),
                      // ),
                    ],
                    // children: [

                    // ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
