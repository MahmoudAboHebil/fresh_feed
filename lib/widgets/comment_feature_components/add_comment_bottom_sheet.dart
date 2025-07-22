import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/models/models.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:fresh_feed/widgets/comment_feature_components/comment_feature_components.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddCommentBottomSheet extends ConsumerStatefulWidget {
  const AddCommentBottomSheet({required this.user, super.key});
  final UserModel user;

  @override
  ConsumerState<AddCommentBottomSheet> createState() =>
      _AddCommentBottomSheetState();
}

class _AddCommentBottomSheetState extends ConsumerState<AddCommentBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isSubmitting = false;
  bool _isDeleting = false;
  bool _pageLoading = true;
  CommentModel? _replaingComment;
  CommentModel? _updatingComment;

  ///todo: you need get the user model for each replay_comment user
  /// todo: you need handle the language and the responsive
  /// todo: you need add comment
  /// todo: you need add function
  /// todo: you need take care about the arrangement of comments list

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _pageLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  final List<CommentModel> models = [
    CommentModel(
        id: "id",
        comment: "Parent 1",
        dateTime: DateTime(2025, 7, 22, 14),
        articleId: "articleId",
        userId: "userId",
        userName: 'ahmed'),
    CommentModel(
        id: "id",
        comment:
            "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaini",
        dateTime: DateTime(2025, 7, 22, 13),
        articleId: "articleId",
        userId: "userId",
        userName: 'mahmoud'),
    CommentModel(
        id: "id",
        comment: "Parent 3",
        dateTime: DateTime(2025, 7, 22, 12),
        articleId: "articleId",
        userId: "userId",
        userName: 'mohammed')
  ];

  void _submitComment(UserModel user) async {
    final comment = _controller.text.trim();
    if (comment.isEmpty) return;

    setState(() => _isSubmitting = true);

    // Simulate API call or comment submission
    await Future.delayed(const Duration(seconds: 1));
    models.insert(
        0,
        CommentModel(
            id: "id",
            comment: comment,
            dateTime: DateTime.now(),
            articleId: "articleId",
            userId: user.uid,
            userName: user.name,
            userImageUrl: user.profileImageUrl));
    _controller.clear();
    setState(() => _isSubmitting = false);
  }

  void replayCommentCallBack(CommentModel comment) {
    FocusScope.of(context).requestFocus(_focusNode);
    setState(() {
      _updatingComment = null;
      _replaingComment = comment;
    });
  }

  void cancelCommentReplaingCallBack() {
    FocusScope.of(context).unfocus();

    setState(() {
      _replaingComment = null;
    });
  }

  void editingCommentCallBack(CommentModel comment) {
    FocusScope.of(context).requestFocus(_focusNode);

    setState(() {
      _replaingComment = null;
      _updatingComment = comment;
    });
  }

  void cancelCommentEditingCallBack() {
    FocusScope.of(context).unfocus();

    setState(() {
      _updatingComment = null;
    });
  }

  void deleteCommentCallBack(CommentModel model) async {
    setState(() {
      _isDeleting = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      models.remove(model);
      _isDeleting = false;
    });
  }

  // used to update the comment
  void updateComment(CommentModel comment) {}

  @override
  Widget build(BuildContext context) {
    // final bottomPadding =
    //     MediaQuery.of(context).viewInsets.bottom; //+>the length of key port

    // final sbottomPadding = MediaQuery.of(context).padding;+> fixed
    // final sbsottomPadding = MediaQuery.of(context).viewPadding;+>the visible UI has value>0

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: context.setHeightScreenBase(0.80),
      padding: EdgeInsetsDirectional.only(
        top: context.setWidth(15),
        // bottom: context.setWidth(bottomPadding + 15),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: context.setWidth(15),
                    end: context.setWidth(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Comments',
                        style: TextStyle(
                            fontSize: context.setSp(18),
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(context
                              .colorScheme.secondaryContainer
                              .withOpacity(0.2)),
                          padding: WidgetStatePropertyAll(
                            EdgeInsetsDirectional.all(context.setMinSize(6)),
                          ),
                        ),
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: context.textTheme.bodyLarge?.color,
                          size: context.setSp(18),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: context.setWidth(6), bottom: context.setWidth(6)),
                  child: Divider(
                    thickness: 0.20,
                    height: 5,
                    color: context.colorScheme.secondaryContainer,
                  ),
                ),
                _isSubmitting
                    ? const CommentLoadingHint(
                        hint: 'Posting comment',
                      )
                    : const SizedBox(),
                _isDeleting
                    ? const CommentLoadingHint(
                        hint: 'Deleting comment',
                      )
                    : const SizedBox(),
                !_pageLoading
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: context.setWidth(15),
                              top: context.setWidth(15),
                              end: context.setWidth(15),
                            ),
                            child: UserCommentListTile(
                              commentModel: models[index],
                              replayCallBack: replayCommentCallBack,
                              editCallBack: editingCommentCallBack,
                              deleteCallBack: deleteCommentCallBack,
                            ),
                          );
                        },
                        itemCount: models.length,
                      )
                    : Padding(
                        padding: EdgeInsetsDirectional.only(
                            top: context.setHeightScreenBase(0.20)),
                        child: SizedBox(
                          height: context.setMinSize(32),
                          width: context.setMinSize(32),
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                Gap(context.setHeightScreenBase(0.10))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _replaingComment != null
                    ? CommentHint(
                        onCanceling: cancelCommentReplaingCallBack,
                        hint: 'Replay to ${_replaingComment?.userName} Comment',
                      )
                    : const SizedBox(),
                _updatingComment != null
                    ? CommentHint(
                        onCanceling: cancelCommentEditingCallBack,
                        hint: 'Editing comment ${_updatingComment?.userName} ',
                      )
                    : const SizedBox(),
                Container(
                  color: context.colorScheme.secondary,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsetsDirectional.only(
                            top: context.setMinSize(8),
                            bottom: context.setMinSize(8),
                            start: context.setMinSize(8),
                            end: context.setMinSize(10),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              textSelectionTheme: TextSelectionThemeData(
                                selectionHandleColor:
                                    context.colorScheme.primary,
                                selectionColor: context.colorScheme.primary,
                              ),
                            ),
                            child: TextField(
                              cursorColor: context.colorScheme.primary,
                              controller: _controller,
                              focusNode: _focusNode,
                              style: TextStyle(
                                  color: context.textTheme.bodyLarge?.color,
                                  fontWeight: FontWeight.w600,
                                  decorationThickness: 0,
                                  fontSize: context.setSp(15)),
                              maxLines: 4,
                              minLines: 1,
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                // fillColor: Theme.of(context).scaffoldBackgroundColor,
                                fillColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                filled: true,
                                hintText: 'Add Comments',
                                hintStyle: TextStyle(
                                    color: context.textTheme.bodyLarge?.color,
                                    fontWeight: FontWeight.w600,
                                    fontSize: context.setSp(15)),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _submitComment(widget.user),
                        child: Icon(
                          Icons.send,
                          color: context.colorScheme.primary,
                          size: context.setMinSize(24),
                        ),
                      ),
                      Gap(context.setWidth(15))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentLoadingHint extends StatelessWidget {
  const CommentLoadingHint({required this.hint, super.key});
  final String hint;

  /// todo: you need handle the language and the responsive

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.secondary,
      padding: const EdgeInsetsDirectional.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.horizontalRotatingDots(
            color: context.colorScheme.primary,
            size: context.setMinSize(30),
          ),
          const Gap(10),
          Text(
            hint,
            style: TextStyle(
              color: context.textTheme.bodyLarge?.color?.withOpacity(0.70),
            ),
          )
        ],
      ),
    );
  }
}

class CommentHint extends StatelessWidget {
  const CommentHint({required this.hint, required this.onCanceling, super.key});
  final String hint;
  final VoidCallback onCanceling;

  /// todo: you need handle the language and the responsive

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsetsDirectional.only(
        top: context.setMinSize(8),
        bottom: context.setMinSize(3),
        start: context.setMinSize(20),
        end: context.setMinSize(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              hint,
              /*'Editing to $userName Comments',*/
              // 'Replay to  Comments df d safas adsfdsa sdfsf',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.textTheme.bodyLarge?.color?.withOpacity(0.90),
              ),
            ),
          ),
          IconButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.transparent),
              padding: WidgetStatePropertyAll(EdgeInsetsDirectional.zero),
            ),
            constraints: const BoxConstraints(),
            onPressed: onCanceling,
            icon: Icon(
              Icons.close,
              color: context.textTheme.bodyLarge?.color,
              size: context.setSp(18),
            ),
          ),
        ],
      ),
    );
  }
}
