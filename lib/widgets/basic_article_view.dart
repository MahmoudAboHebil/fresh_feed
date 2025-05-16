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
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 4,
              blurRadius: 8,
              offset: Offset(0, 0)),
        ],
        color: context.colorScheme.secondary,
        borderRadius: BorderRadius.circular(context.setSp(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: context.setWidth(85),
                width: context.setWidth(125),
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
                      maxLines: 2,
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
          Gap(context.setHeight(5)),
          Divider(
            thickness: 1,
          ),
          Gap(context.setHeight(3)),
          Row(
            children: [
              Container(
                height: context.setWidth(21),
                width: context.setWidth(35),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(4)
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
