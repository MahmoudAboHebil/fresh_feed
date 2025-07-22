import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:gap/gap.dart';

import '../../data/models/models.dart';
import '../../utils/general_functions.dart';

class UserReplayCommentListTile extends StatefulWidget {
  const UserReplayCommentListTile({required this.commentModel, super.key});

  final CommentModel commentModel;

  @override
  State<UserReplayCommentListTile> createState() =>
      _UserReplayCommentListTileState();
}

class _UserReplayCommentListTileState extends State<UserReplayCommentListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.commentModel.userImageUrl != null
            ? CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: context.setMinSize(14),
                backgroundImage: NetworkImage(
                  widget.commentModel.userImageUrl!,
                ),
              )
            : Container(
                height: context.setMinSize(28),
                width: context.setMinSize(28),
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
                            fontSize: context.setSp(12),
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
                            fontSize: context.setSp(11),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.ellipsisVertical,
                      color: context.textTheme.bodyLarge?.color,
                      size: context.setMinSize(16),
                    ),
                  ),
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
                          fontSize: context.setSp(9),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
