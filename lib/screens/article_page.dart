import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/providers/article_view_provider.dart';

class ArticlePage extends ConsumerStatefulWidget {
  final String articleID;
  final String userId;

  const ArticlePage({
    required this.articleID,
    required this.userId,
    super.key,
  });

  @override
  ConsumerState<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends ConsumerState<ArticlePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) async {
      try {
        final viewProv = ref.read(articleViewNotifierProvider.notifier);
        await viewProv.addArticleViewToDataBase(
            widget.articleID, widget.userId);
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final articleViewProvider = ref.watch(articleViewNotifierProvider);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (wasPopped, result) {
        try {
          print(
              'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh===================================');
          final articleViewProvider =
              ref.read(articleViewNotifierProvider.notifier);
          articleViewProvider.addArticleViewToState(
              widget.articleID, widget.userId);
        } catch (e) {
          print(e);
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            const Text('The State is '),
            const SizedBox(
              height: 10,
            ),
            Text(articleViewProvider.toString()),
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
    );
  }
}
