import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/providers/providers.dart';

import '../utils/app_alerts.dart';

class ArticlePage extends ConsumerStatefulWidget {
  final Article article;
  final String userId;

  const ArticlePage({
    required this.article,
    required this.userId,
    super.key,
  });

  @override
  ConsumerState<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends ConsumerState<ArticlePage> {
  bool? isExists;
  @override
  void initState() {
    super.initState();
  }

  bool isArtBookmarksExists(Article article, dynamic state) {
    if (state == null) false;
    return state?.any((art) => art.id == article.id) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final userBookmarksState = ref.watch(userBookmarksNotifierProvider);
    final userBookmarksProv = ref.read(userBookmarksNotifierProvider.notifier);

    ref.listen(userListenerProvider, (prev, now) async {
      print('dddddddddddddddddddddddddddddddddd');
      try {
        await userBookmarksProv.loadDataIfStateIsNull(now?.uid);
      } catch (e) {
        print(e);
      }
    });
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (wasPopped, result) {
        try {
          final userBookmarksNotifier =
              ref.read(userBookmarksNotifierProvider.notifier);

          print(
              'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh===================================');
          if (isExists != null) {
            userBookmarksNotifier.toggleBookmarksFromState(
                widget.article, isExists!);
          }
        } catch (e) {
          print(e);
        }
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
              Text(userBookmarksState.toString()),
              const SizedBox(
                height: 30,
              ),
              IconButton(
                color: Colors.blue,
                icon: isExists ??
                        isArtBookmarksExists(widget.article, userBookmarksState)
                    ? const Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                onPressed: () async {
                  try {
                    final userBookmarksNotifier =
                        ref.read(userBookmarksNotifierProvider.notifier);
                    setState(() {
                      isExists = !(isExists ??
                          isArtBookmarksExists(
                              widget.article, userBookmarksState));
                    });
                    await userBookmarksNotifier.toggleBookmarkFromDataBase(
                        widget.article, widget.userId);
                  } catch (e) {
                    print(e.toString());
                    AppAlerts.displaySnackBar(e.toString(), context);
                  }
                },
              ),
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
