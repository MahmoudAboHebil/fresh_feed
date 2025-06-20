import 'package:flutter/material.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:fresh_feed/utils/general_functions.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../config/route/route_name.dart';

class ArticleCart extends StatelessWidget {
  const ArticleCart({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    final functions = GeneralFunctions(context);
    return InkWell(
      onTap: () {
        context.pushNamed(RouteName.articlePage, extra: article);
      },
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Container(
        height: context.setWidth(205),
        width: context.setWidth(420),
        // width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.setWidth(12)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(article.urlToImage!),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black12,
                    Colors.black87,
                  ],
                ),
                borderRadius: BorderRadius.circular(context.setWidth(12)),
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.symmetric(
                vertical: context.setWidth(10),
                horizontal: context.setWidth(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: context.setWidth(4),
                      horizontal: context.setWidth(7),
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(context.setWidth(6)),
                        color: context.colorScheme.primary),
                    child: Text(
                      article.source?.name ?? "",
                      style: TextStyle(
                          color: Colors.white, fontSize: context.setSp(12)),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            color: Colors.white, fontSize: context.setSp(15)),
                      ),
                      Gap(context.setWidth(10)),
                      Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.white,
                            size: context.setWidth(20),
                          ),
                          Gap(context.setWidth(10)),
                          article.publishedAt != null
                              ? Text(
                                  GeneralFunctions.timeAgo(
                                      article.publishedAt!),
                                  style: TextStyle(
                                    fontSize: context.setSp(12),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : SizedBox()
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
