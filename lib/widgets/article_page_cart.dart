import 'package:flutter/material.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:gap/gap.dart';

// size
class ArticlePageCart extends StatelessWidget {
  const ArticlePageCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.setWidth(320),
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
          Container(
            height: context.setWidth(160),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.setMinSize(8)),
                  topRight: Radius.circular(context.setMinSize(8))),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://www.industrialempathy.com/img/remote/ZiClJf-640w.avif"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.setMinSize(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(context.setHeight(8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: context.setWidth(21 * 1.5),
                      width: context.setWidth(35 * 1.5),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(context.setSp(4))

                          // image: DecorationImage(
                          //   fit: BoxFit.cover,
                          //   image: NetworkImage(
                          //       "https://www.thesun.co.uk/wp-content/uploads/2025/02/image_cb6d5f.png?strip=all&w=960"),
                          // ),

                          ),
                    ),
                    Gap(context.setWidth(12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Times of India',
                            style: TextStyle(fontSize: context.setSp(15)),
                          ),
                          Text(
                            '6 days ago',
                            style: TextStyle(
                                fontSize: context.setSp(12),
                                color: context.colorScheme.tertiaryContainer),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(context.setHeight(13)),
                Text(
                  'Tamannaah Bhatia looks like a dream in pristine white gown',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color:
                          context.textTheme.bodyLarge?.color?.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                      fontSize: context.setSp(13)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
