import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/providers/article_view_provider.dart';

import '../data/models/news_models/news_article.dart';
import '../utils/app_alerts.dart';

class ArticlesViewPage extends ConsumerStatefulWidget {
  final String articleID;
  final String? userId;
  final List<Article> articles;

  const ArticlesViewPage({
    required this.articleID,
    required this.articles,
    this.userId,
    super.key,
  });

  @override
  ConsumerState<ArticlesViewPage> createState() => _ArticlePageState();
}

class _ArticlePageState extends ConsumerState<ArticlesViewPage> {
  bool isAdded = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) async {
      try {
        setState(() {
          isLoading = true;
        });
        final viewNotifier = ref.read(articleViewNotifierProvider.notifier);
        List<String> ids = widget.articles.map((mod) => mod.id).toList();
        await viewNotifier.getArticleViewsWhereInByIds(ids);

        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (wasPopped, result) async {
        if (widget.userId != null) {}
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text('The State is '),
              const SizedBox(
                height: 10,
              ),
              Text(ref.watch(articleViewNotifierProvider)?.length.toString() ??
                  'null'),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 30,
              ),
              !isLoading
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final myArticle = widget.articles[index];

                        return Center(
                          child: ArticleComp(
                              articleID: myArticle.id, userId: widget.userId!),
                        );
                      },
                      separatorBuilder: (context, index) => Container(
                        margin: const EdgeInsets.all(15),
                        height: 2,
                        color: Colors.grey,
                      ),
                      itemCount: widget.articles.length,
                    )
                  : CircularProgressIndicator(),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                color: Colors.purple,
                child: const Text('Go Back'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleComp extends ConsumerStatefulWidget {
  const ArticleComp({required this.articleID, required this.userId, super.key});
  final String articleID;
  final String userId;

  @override
  ConsumerState<ArticleComp> createState() => _ArticleCompState();
}

class _ArticleCompState extends ConsumerState<ArticleComp> {
  @override
  Widget build(BuildContext context) {
    final isExist = ref
            .watch(articleViewNotifierProvider)
            ?.any((mode) => mode.articleId == widget.articleID) ??
        false;
    final viewModel = isExist
        ? ref
            .watch(articleViewNotifierProvider)
            ?.firstWhere((mode) => mode.articleId == widget.articleID)
        : null;
    return Column(
      children: [
        Text(viewModel.toString()),
        const SizedBox(
          height: 10,
        ),
        MaterialButton(
          color: Colors.green,
          child: const Text('Add to DB'),
          onPressed: () async {
            try {
              final viewNotifier =
                  ref.read(articleViewNotifierProvider.notifier);
              await viewNotifier.addArticleView(
                  widget.articleID, widget.userId, viewModel);
            } catch (e) {
              AppAlerts.displaySnackBar(e.toString(), context);
            }
          },
        ),
      ],
    );
  }
}
