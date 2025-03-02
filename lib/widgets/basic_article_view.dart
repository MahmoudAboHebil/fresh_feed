import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:gap/gap.dart';

// size
class BasicArticleView extends StatelessWidget {
  const BasicArticleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: context.setHeight(200),
      padding: EdgeInsetsDirectional.symmetric(
        vertical: context.setWidth(10),
        horizontal: context.setWidth(10),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0.5,
            blurRadius: 3,
            offset: Offset(1, 1),
          ),
        ],
        color: context.colorScheme.secondary,
        borderRadius: BorderRadius.circular(context.setSp(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: context.setWidth(80),
                width: context.setWidth(120),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.setMinSize(10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://www.thesun.co.uk/wp-content/uploads/2025/02/image_cb6d5f.png?strip=all&w=960"),
                  ),
                ),
              ),
              Gap(context.setWidth(10)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kasehatan Paus Fransisku dsadfsdf',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: context.setSp(14)),
                    ),
                    Gap(context.setHeight(8)),
                    Text(
                      'Kasehatan Paus Fransisku dsadfsdf',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: context.setSp(14)),
                    ),
                  ],
                ),
              )
            ],
          ),
          Gap(context.setHeight(10)),
          Row(
            children: [
              Container(
                height: context.setHeight(21),
                width: context.setHeight(35),
                decoration: BoxDecoration(color: Colors.red
                    // image: DecorationImage(
                    //   fit: BoxFit.cover,
                    //   image: NetworkImage(
                    //       "https://www.thesun.co.uk/wp-content/uploads/2025/02/image_cb6d5f.png?strip=all&w=960"),
                    // ),
                    ),
              ),
              Gap(context.setWidth(8)),
              Text(
                'News Hunt',
                style: TextStyle(fontSize: context.setSp(13)),
              ),
              Gap(context.setWidth(10)),
              Expanded(
                child: Text(
                  '20 hours ago',
                  style: TextStyle(
                      fontSize: context.setSp(12),
                      color: context.colorScheme.tertiary),
                ),
              ),
              Icon(
                Icons.remove_red_eye_outlined,
                color: context.colorScheme.tertiary.withOpacity(0.8),
                size: context.setSp(23),
              ),
              Gap(context.setWidth(2)),
              Text(
                '2',
                style: TextStyle(
                  fontSize: context.setSp(15),
                  color: context.colorScheme.tertiary.withOpacity(0.8),
                ),
              ),
              Gap(context.setWidth(10)),
              Icon(
                Icons.more_vert,
                color: context.colorScheme.tertiary.withOpacity(0.8),
                size: context.setSp(23),
              ),
            ],
          )
        ],
      ),
    );
  }
}
