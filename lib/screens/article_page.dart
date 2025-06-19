import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/loading_components/loading_components.dart';
import 'package:fresh_feed/providers/font_size_provider.dart';
import 'package:fresh_feed/utils/extensions.dart';
import 'package:fresh_feed/utils/general_functions.dart';
import 'package:fresh_feed/widgets/article_page_cart.dart';
import 'package:fresh_feed/widgets/rectangle_text_button.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../config/route/route_name.dart';
import '../providers/article_view_provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_alerts.dart';
import '../utils/font_size.dart';

class FollowIconButton extends StatefulWidget {
  const FollowIconButton({super.key});

  @override
  State<FollowIconButton> createState() => _FollowIconButtonState();
}

/// todo: you need handling lost network connection
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
  List<Article> relatedArticles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((c) async {
      try {
        final user = await ref.read(authStateNotifierProvider.future);
        if (user != null) {
          final viewNotifier = ref.read(articleViewNotifierProvider.notifier);
          await viewNotifier.addArticleView(widget.article.id, user.uid);
        }
      } catch (e) {
        AppAlerts.displaySnackBar(e.toString(), context);
      }
      final prov = ref.read(newsApiRepoProvider);
      setState(() {
        isLoading = true;
      });
      await prov
          .fetchFullTopHeadlinesArticles(
              count: 3,
              countWidth: 3,
              query:
                  GeneralFunctions.buildNewsQuery(widget.article.title ?? ""))
          .then(
            (value) => setState(() {
              print(widget.article.title);
              relatedArticles = value;
              isLoading = false;
            }),
          )
          .whenComplete(
            () => setState(() {
              isLoading = false;
            }),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final fontValue = ref.watch(fontSizeProvider);
    final isExist = ref
            .watch(articleViewNotifierProvider)
            ?.any((mode) => mode.articleId == widget.article.id) ??
        false;
    final viewModel = isExist
        ? ref
            .watch(articleViewNotifierProvider)
            ?.firstWhere((mode) => mode.articleId == widget.article.id)
        : null;
    final numbersOfView = viewModel?.usersId.length ?? 0;
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
      body: !isLoading
          ? Container(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: context.setMinSize(10),
                  vertical: context.setMinSize(15)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: context.setWidth(220),
                      width: context.screenWidth,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(context.setWidth(8)),
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
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: context.setSp(16)),
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
                        widget.article.publishedAt != null
                            ? Text(
                                GeneralFunctions.timeAgo(
                                    widget.article.publishedAt!),
                                style: TextStyle(
                                    fontSize: context.setSp(15),
                                    color: context.colorScheme.tertiary),
                              )
                            : SizedBox(),
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
                              '$numbersOfView View',
                              style: TextStyle(
                                fontSize: context.setSp(12),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            final fontProv =
                                ref.read(fontSizeProvider.notifier);

                            AppAlerts.displayTextSizing(
                                context,
                                ref.read(fontSizeProvider).value ??
                                    FontSize.medium, (font) async {
                              try {
                                await fontProv.toggleFontSize(font);
                              } catch (e) {
                                AppAlerts.displaySnackBar(
                                    e.toString(), context);
                              }
                            });
                          },
                          child: Column(
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
                        ),
                      ],
                    ),
                    Gap(context.setHeight(20)),
                    fontValue.when(
                      data: (data) {
                        return Text(
                          widget.article.content ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: context.setSp(data.size)),
                        );
                      },
                      error: (e, stc) {
                        return Text(
                          widget.article.content ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: context.setSp(15)),
                        );
                      },
                      loading: () {
                        return Text(
                          widget.article.content ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: context.setSp(15)),
                        );
                      },
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
                          color:
                              context.colorScheme.onPrimary.withOpacity(0.80),
                          icon: FaIcon(
                            FontAwesomeIcons.shareFromSquare,
                            size: context.setSp(16),
                            color:
                                context.colorScheme.onPrimary.withOpacity(0.80),
                          ),
                          callback: () async {
                            if (widget.article.url != null) {
                              context.pushNamed(
                                RouteName.webViewArticlePage,
                                extra: widget.article,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Gap(context.setHeight(18)),
                    relatedArticles.isNotEmpty
                        ? Text(
                            'Related Posts',
                            style: TextStyle(
                                color: context.textTheme.bodyLarge?.color
                                    ?.withOpacity(0.9),
                                fontSize: context.setSp(16),
                                fontWeight: FontWeight.w600),
                          )
                        : SizedBox(),
                    Gap(context.setHeight(12)),
                    relatedArticles.isNotEmpty
                        ? Container(
                            height: context.setSp(288),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: context.setMinSize(20)),
                                  child: ArticlePageCart(
                                    article: relatedArticles[index],
                                  ),
                                );
                              },
                              itemCount: relatedArticles.length,
                              scrollDirection: Axis.horizontal,
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            )
          : ShellLoading(),
    );
  }
}
