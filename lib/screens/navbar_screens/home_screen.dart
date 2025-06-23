import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/providers/providers.dart';
import 'package:fresh_feed/screens/navbar_screens/home_screen_content/home_screen_content.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../generated/l10n.dart';
import '../../widgets/user_comment_list_tile.dart';

// ToDO: font type
// ToDO: languages
// ToDO: enhance the images widgets
// ToDO: creating the loading screen and Refresh button

// note: basic article cart / recommend Article cart/ channel cart
// there are not article pagination here
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static HomeScreen builder(BuildContext buildContext, GoRouterState state) =>
      const HomeScreen();
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      length: 7,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider);
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          toolbarHeight: context.setMinSize(50),
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: Image.asset(
            'assets/main_logo.png',
            height: context.setMinSize(32),
          ),
          bottom: TabBar(
            controller: _controller,
            padding: EdgeInsets.zero,
            indicatorWeight: context.setSp(2),

            // indicatorPadding: EdgeInsetsGeometry.(bottom: 0, top: 40),
            labelPadding: EdgeInsetsDirectional.only(
              start: context.setWidth(16),
              end: context.setWidth(16),
            ),
            tabAlignment: TabAlignment.start,
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            physics: AlwaysScrollableScrollPhysics(),

            isScrollable: true,
            unselectedLabelColor: context.colorScheme.secondaryContainer,
            labelStyle: TextStyle(
                fontSize: context.setSp(17), fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
                fontSize: context.setSp(16), fontWeight: FontWeight.w500),
            dividerHeight: 0,
            tabs: [
              Tab(
                child: Text(S.of(context).ForYou),
              ),
              Tab(
                child: Text(
                  S.of(context).Sports,
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).Business,
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).Technology,
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).Health,
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).Entertainment,
                ),
              ),
              Tab(
                child: Text(
                  S.of(context).SeeAll,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            ForYouContent(),
            user.when(
              data: (user) {
                return InkWell(
                  onTap: () async {
                    showAddCommentBottomSheet(context, user!);
                  },
                  child: Icon(Icons.directions_transit),
                );
              },
              error: (error, stackTrace) => Container(),
              loading: () => CircularProgressIndicator(),
            ),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}

void showAddCommentBottomSheet(BuildContext context, UserModel user) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    constraints: BoxConstraints(
        minWidth: context.screenWidth, maxWidth: context.screenWidth),

    isScrollControlled: true, // To push the sheet above the keyboard
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(builder: (context, setDialogState) {
        return AddCommentBottomSheet(
          user: user,
        );
      });
    },
  );
}

class AddCommentBottomSheet extends ConsumerStatefulWidget {
  const AddCommentBottomSheet({required this.user, Key? key}) : super(key: key);
  final UserModel user;

  @override
  ConsumerState<AddCommentBottomSheet> createState() =>
      _AddCommentBottomSheetState();
}

class _AddCommentBottomSheetState extends ConsumerState<AddCommentBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _isSubmitting = false;

  ///todo: you need get the user model for each replay_comment user
  /// todo: you need handle the language and the responsive
  /// todo: you need add comment
  /// todo: you need add function
  /// todo: you need take care about the arrangement of comments list
  void _submitComment() async {
    final comment = _controller.text.trim();
    if (comment.isEmpty) return;

    setState(() => _isSubmitting = true);

    // Simulate API call or comment submission
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isSubmitting = false);

    // Return the comment or just close
    Navigator.pop(context, comment); // You can pass the result if needed
  }

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
            physics: AlwaysScrollableScrollPhysics(),
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
                        constraints: BoxConstraints(),
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
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: context.setWidth(15),
                        top: context.setWidth(15),
                        end: context.setWidth(15),
                      ),
                      child: UserCommentListTile(
                        user: widget.user,
                        commentModel: CommentModel(
                          id: "id",
                          comment: "Parent 1",
                          dateTime: DateTime.now(),
                          articleId: "articleId",
                          userId: "userId",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: context.setWidth(15),
                        top: context.setWidth(15),
                        end: context.setWidth(15),
                      ),
                      child: UserCommentListTile(
                        user: widget.user,
                        commentModel: CommentModel(
                          id: "id",
                          comment:
                              "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaini",
                          dateTime: DateTime.now(),
                          articleId: "articleId",
                          userId: "userId",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: context.setWidth(15),
                        top: context.setWidth(15),
                        end: context.setWidth(15),
                      ),
                      child: UserCommentListTile(
                        user: widget.user,
                        commentModel: CommentModel(
                          id: "id",
                          comment: "Parent 3",
                          dateTime: DateTime.now(),
                          articleId: "articleId",
                          userId: "userId",
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(context.setHeightScreenBase(0.10))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
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
                            selectionHandleColor: context.colorScheme.primary,
                            selectionColor: context.colorScheme.primary,
                          ),
                        ),
                        child: TextField(
                          cursorColor: context.colorScheme.primary,
                          controller: _controller,
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
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.transparent),
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
                  Icon(
                    Icons.send,
                    color: context.colorScheme.primary,
                    size: context.setMinSize(24),
                  ),
                  Gap(context.setWidth(15))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*
class CommentsWidget extends StatefulWidget {
  const CommentsWidget({super.key});

  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
*/

final articleCartData = [
  {
    "image":
        "https://www.thesun.co.uk/wp-content/uploads/2025/02/image_cb6d5f.png?strip=all&w=960"
  },
  {
    "image":
        "https://www.thesun.co.uk/wp-content/uploads/2025/02/image_cb6d5f.png?strip=all&w=960"
  },
  {
    "image":
        "https://i0.wp.com/plopdo.com/wp-content/uploads/2021/11/feature-pic.jpg?w=537&ssl=1"
  },
  {
    "image":
        "https://cdn.futura-sciences.com/cdn-cgi/image/width=1520,quality=50,format=auto/sources/images/AI-creation.jpg"
  },
  {"image": "https://www.industrialempathy.com/img/remote/ZiClJf-640w.avif"}
];
