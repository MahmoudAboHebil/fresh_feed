import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/screens/screens.dart';

import '../data/models/comment_model.dart';
import '../data/models/news_models/news_article.dart';
import '../providers/article_comment_provider.dart';
import '../utils/app_alerts.dart';

class ArticlesCommentPage extends ConsumerStatefulWidget {
  final String? userId;
  final List<Article> articles;

  const ArticlesCommentPage({
    required this.articles,
    this.userId,
    super.key,
  });

  @override
  ConsumerState<ArticlesCommentPage> createState() =>
      _ArticleCommentPageState();
}

class _ArticleCommentPageState extends ConsumerState<ArticlesCommentPage> {
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
        final viewNotifier = ref.read(articleCommentProvider.notifier);
        List<String> ids = widget.articles.map((mod) => mod.id).toList();
        await viewNotifier.getArticlesCommentsWhereInByIds(ids);
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
      onPopInvokedWithResult: (wasPopped, result) async {},
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
              Text(ref.watch(articleCommentProvider)?.length.toString() ??
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
                          child: ArticleCommentComp(
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInUp(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleCommentComp extends ConsumerStatefulWidget {
  const ArticleCommentComp(
      {required this.articleID, required this.userId, super.key});
  final String articleID;
  final String userId;

  @override
  ConsumerState<ArticleCommentComp> createState() => _ArticleCompState();
}

class _ArticleCompState extends ConsumerState<ArticleCommentComp> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isExist = ref
            .watch(articleCommentProvider)
            ?.any((mode) => mode['articleId'] == widget.articleID) ??
        false;
    final comments = isExist
        ? ref.watch(articleCommentProvider)?.firstWhere(
                (mode) => mode['articleId'] == widget.articleID)['comments']
            as List<CommentModel>
        : null;
    return Column(
      children: [
        Text(comments.toString()),
        const SizedBox(
          height: 10,
        ),
        comments != null && comments.length > 3
            ? Column(
                children: [
                  MaterialButton(
                    color: Colors.yellow,
                    child: const Text('update Comment'),
                    onPressed: () async {
                      try {
                        await ref
                            .read(articleCommentProvider.notifier)
                            .updateArtComment(
                              'updatinggg',
                              comments[1],
                            );
                      } catch (e) {
                        AppAlerts.displaySnackBar(e.toString(), context);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    color: Colors.red,
                    child: const Text('Delete'),
                    onPressed: () async {
                      try {
                        await ref
                            .read(articleCommentProvider.notifier)
                            .deleteArtComment(comments[1]);
                      } catch (e) {
                        AppAlerts.displaySnackBar(e.toString(), context);
                      }
                    },
                  ),
                ],
              )
            : Container(),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Message',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        MaterialButton(
          color: Colors.green,
          child: const Text('Add Comment'),
          onPressed: () async {
            try {
              await ref
                  .read(articleCommentProvider.notifier)
                  .addArticleComment(CommentModel(
                    comment: _controller.text,
                    dateTime: DateTime.now(),
                    articleId: widget.articleID,
                    userId: widget.userId,
                  ));
            } catch (e) {
              AppAlerts.displaySnackBar(e.toString(), context);
            }
          },
        ),
      ],
    );
  }
}
