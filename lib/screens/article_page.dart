import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:fresh_feed/widgets/article_page_cart.dart';
import 'package:fresh_feed/widgets/rectangle_text_button.dart';
import 'package:gap/gap.dart';

class FollowIconButton extends StatefulWidget {
  const FollowIconButton({super.key});

  @override
  State<FollowIconButton> createState() => _FollowIconButtonState();
}

class _FollowIconButtonState extends State<FollowIconButton> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isActive = !isActive;
        });
      },
      icon: isActive
          ? Icon(
              Icons.bookmark,
              color: context.colorScheme.primary,
              size: context.setSp(26),
            )
          : Icon(Icons.bookmark_outline_outlined,
              color: Color(0xff9b9b9b), size: context.setSp(26)),
    );
  }
}

class ArticlePage extends ConsumerStatefulWidget {
  const ArticlePage({required this.article, super.key});
  final Article article;

  @override
  ConsumerState<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends ConsumerState<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: context.textTheme.bodyLarge?.color,
        ),
        actions: [
          FollowIconButton(),
        ],
        backgroundColor: Colors.transparent,
        toolbarHeight: context.setMinSize(50),
        scrolledUnderElevation: 0,
      ),
      body: Container(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: context.setMinSize(10),
            vertical: context.setMinSize(15)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: context.setWidth(220),
                width: context.setWidth(420),
                // width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.setWidth(8)),
                  image: DecorationImage(
                    fit: BoxFit.cover,

                    ///todo: handling the missing image
                    image: NetworkImage(widget.article.urlToImage!),
                  ),
                ),
              ),
              Gap(context.setHeight(15)),
              Text(
                widget.article.title ?? "",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: context.setSp(16)),
              ),
              Gap(context.setHeight(15)),
              Row(
                children: [
                  Container(
                    height: context.setWidth(29),
                    width: context.setWidth(48),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4)
                        // image: DecorationImage(
                        //   fit: BoxFit.cover,
                        //   image: NetworkImage(
                        //       "https://www.thesun.co.uk/wp-content/uploads/2025/02/image_cb6d5f.png?strip=all&w=960"),
                        // ),
                        ),
                  ),
                  Gap(context.setWidth(8)),
                  Text(
                    widget.article.source?.name ?? "",
                    style: TextStyle(
                      fontSize: context.setSp(15),
                      color: context.colorScheme.tertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    '20 hours ago',
                    style: TextStyle(
                        fontSize: context.setSp(15),
                        color: context.colorScheme.tertiary),
                  ),
                ],
              ),
              Gap(context.setHeight(15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // comments
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.comments,
                        size: context.setSp(20),
                      ),
                      Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: context.setSp(12),
                        ),
                      ),
                    ],
                  ),
                  // Like
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.thumbsUp,
                        size: context.setSp(20),
                      ),
                      Text(
                        'Like',
                        style: TextStyle(
                          fontSize: context.setSp(12),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.remove_red_eye_outlined,
                        size: context.setSp(23),
                      ),
                      Text(
                        '29 View',
                        style: TextStyle(
                          fontSize: context.setSp(12),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.text_fields_outlined,
                        size: context.setSp(22),
                      ),
                      Text(
                        'Text size',
                        style: TextStyle(
                          fontSize: context.setSp(12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Gap(context.setHeight(20)),
              Text(
                "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: context.setSp(15)),
              ),
              Gap(context.setHeight(18)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RectangleTextButton(
                    verticalPadding: 10,
                    horizontalPadding: 18,
                    text: 'Click here to read more',
                    fontSize: 14,
                    expanded: false,
                    backgroundColor: context.colorScheme.primary,
                    color: context.colorScheme.onPrimary.withOpacity(0.80),
                    icon: FaIcon(
                      FontAwesomeIcons.shareFromSquare,
                      size: context.setSp(16),
                      color: context.colorScheme.onPrimary.withOpacity(0.80),
                    ),
                    callback: () async {
                      await Future.delayed(Duration(seconds: 2));
                    },
                  ),
                ],
              ),
              Gap(context.setHeight(18)),
              Text(
                'Related Posts',
                style: TextStyle(
                    color: context.textTheme.bodyLarge?.color?.withOpacity(0.9),
                    fontSize: context.setSp(16),
                    fontWeight: FontWeight.w600),
              ),
              Gap(context.setHeight(12)),
              Container(
                height: context.setSp(285),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: context.setMinSize(20)),
                      child: ArticlePageCart(),
                    );
                  },
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
