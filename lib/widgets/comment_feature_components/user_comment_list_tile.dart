import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:fresh_feed/widgets/comment_feature_components/user_replay_comment_list_tile.dart';
import 'package:gap/gap.dart';

import '../../data/models/models.dart';
import '../../utils/general_functions.dart';

class UserCommentListTile extends StatefulWidget {
  const UserCommentListTile(
      {required this.commentModel,
      required this.replayCallBack,
      required this.editCallBack,
      required this.deleteCallBack,
      super.key});

  final CommentModel commentModel;
  final void Function(CommentModel) replayCallBack;
  final void Function(CommentModel) editCallBack;
  final void Function(CommentModel) deleteCallBack;

  @override
  State<UserCommentListTile> createState() => _UserCommentListTileState();
}

class _UserCommentListTileState extends State<UserCommentListTile> {
  bool viewReplays = false;
  List<CommentModel> list = [
    CommentModel(
      id: "id",
      comment: 'replay 1',
      dateTime: DateTime.now(),
      articleId: "articleId",
      userId: "userId",
      userName: 'ahmed',
    ),
    CommentModel(
        id: "id",
        comment:
            "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaini",
        dateTime: DateTime.now(),
        articleId: "articleId",
        userId: "userId",
        userName: 'mahmoud'),
    CommentModel(
        id: "id",
        comment: 'replay 3',
        dateTime: DateTime.now(),
        articleId: "articleId",
        userId: "userId",
        userName: 'Mohammed'),
  ];

  @override
  Widget build(BuildContext context) {
    final generalFunction = GeneralFunctions(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.commentModel.userImageUrl != null
            ? CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: context.setMinSize(16),
                backgroundImage: NetworkImage(
                  widget.commentModel.userImageUrl!,
                ),
              )
            : Container(
                height: context.setMinSize(32),
                width: context.setMinSize(32),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: FaIcon(
                  FontAwesomeIcons.user,
                  color: Colors.white,
                  size: context.setMinSize(15),
                ),
              ),
        Gap(context.setWidth(16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.commentModel.userName,
                          style: TextStyle(
                            color: context.textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.w600,
                            fontSize: context.setSp(13),
                          ),
                        ),
                        Gap(
                          context.setWidth(5),
                        ),
                        Text(
                          widget.commentModel.comment,
                          style: TextStyle(
                            color: const Color(0xff9b9b9b),
                            fontWeight: FontWeight.w500,
                            fontSize: context.setSp(12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Builder(builder: (buttonContext) {
                    return IconButton(
                      onPressed: () async {
                        await generalFunction.showEditeCommentMenu(
                          comment: widget.commentModel,
                          buttonContext: buttonContext,
                          editCallBack: widget.editCallBack,
                          deleteCallBack: widget.deleteCallBack,
                          reportCallBack: () {},
                        );
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.ellipsisVertical,
                        color: context.textTheme.bodyLarge?.color,
                        size: context.setMinSize(18),
                      ),
                    );
                  }),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    top: context.setWidth(3), bottom: context.setWidth(8)),
                child: Divider(
                  thickness: 0.20,
                  height: 0,
                  color: context.colorScheme.secondaryContainer,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StreamBuilder<DateTime>(
                    stream: Stream.periodic(
                        const Duration(minutes: 1), (_) => DateTime.now()),
                    initialData: DateTime.now(),
                    builder: (context, snapshot) {
                      return Text(
                        GeneralFunctions.timeAgo(
                            (widget.commentModel.modifiedDateTime ??
                                    widget.commentModel.dateTime)
                                .toString()),
                        style: TextStyle(
                          color: const Color(0xff9b9b9b),
                          fontWeight: FontWeight.w600,
                          fontSize: context.setSp(10),
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.symmetric(
                        horizontal: context.setWidth(8)),
                    decoration: const BoxDecoration(
                        color: Color(0xff9b9b9b), shape: BoxShape.circle),
                    width: 6,
                    height: 6,
                  ),
                  InkWell(
                    onTap: () {
                      widget.replayCallBack(widget.commentModel);
                    },
                    child: Text(
                      'Replay',
                      style: TextStyle(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: context.setSp(10),
                      ),
                    ),
                  ),
                  list.isNotEmpty
                      ? SizedBox(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsetsDirectional.symmetric(
                                    horizontal: context.setWidth(8)),
                                decoration: const BoxDecoration(
                                    color: Color(0xff9b9b9b),
                                    shape: BoxShape.circle),
                                width: 6,
                                height: 6,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    viewReplays = !viewReplays;
                                  });
                                },
                                child: Text(
                                  'View Reply (${list.length})',
                                  style: TextStyle(
                                    color: context.colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: context.setSp(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox()
                ],
              ),
              // replay comment
              ///todo: you need get the user model for each comment user
              viewReplays
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsetsDirectional.only(
                            top: context.setWidth(15),
                          ),
                          child: UserReplayCommentListTile(
                            key: UniqueKey(),
                            commentModel: list[index],
                          ),
                        );
                      },
                      itemCount: list.length,
                    )
                  : SizedBox()
            ],
          ),
        )
      ],
    );
  }
}
