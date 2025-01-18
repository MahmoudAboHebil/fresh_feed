import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/providers/article_view_provider.dart';

class ArticlesViewPage extends ConsumerStatefulWidget {
  final String articleID;
  final String? userId;

  const ArticlesViewPage({
    required this.articleID,
    this.userId,
    super.key,
  });

  @override
  ConsumerState<ArticlesViewPage> createState() => _ArticlePageState();
}

class _ArticlePageState extends ConsumerState<ArticlesViewPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) async {
      try {
        final viewProv = ref.read(articleViewNotifierProvider.notifier);
        await viewProv.loadDataIfStateIsNull();
        if (widget.userId != null) {
          await viewProv.addArticleViewToDataBase(
              widget.articleID, widget.userId!);
        }
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
        if (widget.userId != null) {
          try {
            final articleViewProvider =
                ref.read(articleViewNotifierProvider.notifier);
            articleViewProvider.addArticleViewToState(
                widget.articleID, widget.userId!);
          } catch (e) {
            print(e);
          }
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
