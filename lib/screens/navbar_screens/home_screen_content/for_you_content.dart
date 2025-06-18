import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/utils/utlis.dart';
import 'package:fresh_feed/widgets/widgets.dart';
import 'package:gap/gap.dart';

import '../../../data/models/news_models/news_article.dart';
import '../../../providers/for_you_data_provider.dart';

//todo: implement the clicking DurationArticleCarts widget to go to the article details page

class ForYouContent extends ConsumerStatefulWidget {
  const ForYouContent({super.key});

  @override
  ConsumerState<ForYouContent> createState() => _HomeContentScreenState();
}

class _HomeContentScreenState extends ConsumerState<ForYouContent> {
  bool isLoading = true;
  List<Article> durationArticles = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProv = ref.watch(forYouScreenDataProvider);
    final notifier = ref.read(forYouScreenDataProvider.notifier);
    return dataProv.when(
      data: (data) {
        return RefreshIndicator(
          onRefresh: () => notifier.refreshData(),
          child: Container(
            margin: EdgeInsetsDirectional.symmetric(
              vertical: context.setWidth(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.symmetric(
                      horizontal: context.setHeight(15),
                    ),
                    child: DurationArticleCarts(
                      articles: data.durationCartData,
                    ),
                  ),
                  Gap(context.setHeight(15)),
                  // Popular News
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: context.setMinSize(25),
                        vertical: context.setMinSize(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular News',
                          style: TextStyle(
                              color: context.textTheme.bodyLarge?.color
                                  ?.withOpacity(0.9),
                              fontSize: context.setSp(16),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                              color: context.colorScheme.tertiary,
                              fontSize: context.setSp(14)),
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(
                    5,
                    (index) => Padding(
                      padding: EdgeInsetsDirectional.only(
                        bottom: context.setHeight(20),
                        end: context.setHeight(15),
                        start: context.setHeight(15),
                      ),
                      child: BasicArticleView(),
                    ),
                  ),
                  Gap(context.setHeight(10)),

                  // Channels
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: context.setMinSize(25),
                        vertical: context.setMinSize(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Channels you may like',
                          style: TextStyle(
                              color: context.textTheme.bodyLarge?.color
                                  ?.withOpacity(0.9),
                              fontSize: context.setSp(16),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                              color: context.colorScheme.tertiary,
                              fontSize: context.setSp(14)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    // width: 300,

                    margin: EdgeInsetsDirectional.symmetric(
                      horizontal: context.setHeight(15),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsetsDirectional.symmetric(
                              horizontal: context.setWidth(8)),
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: context.setWidth(6),
                              vertical: context.setWidth(12)),
                          width: 115,
                          decoration: BoxDecoration(
                            color: context.colorScheme.secondary,
                            borderRadius:
                                BorderRadius.circular(context.setSp(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: context.setWidth(38),
                                width: context.setWidth(63),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8)
                                    // image: DecorationImage(
                                    //   fit: BoxFit.cover,
                                    //   image: NetworkImage(
                                    //       "https://www.thesun.co.uk/wp-content/uploads/2025/02/image_cb6d5f.png?strip=all&w=960"),
                                    // ),
                                    ),
                              ),
                              Text(
                                'Times of Indian',
                                style: TextStyle(
                                    color: context.textTheme.bodyLarge?.color
                                        ?.withOpacity(0.8),
                                    fontSize: context.setSp(14),
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: BorderTextButton(
                                        padding: Size(context.setWidth(5),
                                            context.setWidth(5)),
                                        text: 'Follow',
                                        textSize: 12,
                                        color: context.colorScheme.onPrimary,
                                        borderColor:
                                            context.colorScheme.primary,
                                        backgroundColor:
                                            context.colorScheme.primary,
                                        callback: () {}),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Gap(context.setHeight(10)),
                  // Recommendation News
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: context.setMinSize(25),
                        vertical: context.setMinSize(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recommendation',
                          style: TextStyle(
                              color: context.textTheme.bodyLarge?.color
                                  ?.withOpacity(0.9),
                              fontSize: context.setSp(16),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                              color: context.colorScheme.tertiary,
                              fontSize: context.setSp(14)),
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(
                    2,
                    (index) => Padding(
                      padding: EdgeInsetsDirectional.only(
                        bottom: context.setHeight(14),
                        end: context.setHeight(15),
                        start: context.setHeight(15),
                      ),
                      child: RecommendArticleCart(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        //ToDo: handling empty data
        /*
        if (data.isNotEmpty ) {
          return
        }
        return CircularProgressIndicator();

         */
      },
      error: (error, stackTrace) => const AppErrorWidget(
        buttonText: null,
        callBack: null,
      ),
      loading: () => CircularProgressIndicator(),
    );
  }
}
