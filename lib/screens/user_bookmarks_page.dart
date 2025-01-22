import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/providers/providers.dart';

import '../utils/app_alerts.dart';
import 'followed_channels_page.dart';

class BookmarksPage extends ConsumerStatefulWidget {
  final String userId;

  const BookmarksPage({
    required this.userId,
    super.key,
  });
  @override
  ConsumerState<BookmarksPage> createState() => _ArticlePageState();
}

class _ArticlePageState extends ConsumerState<BookmarksPage> {
  bool? isExists;
  List<Map<String, Object>> modifiedStateList = [];
  void updateTheStateBeforeLeaving() {
    for (int i = 0; i < modifiedStateList.length; i++) {
      final itemMap = modifiedStateList[i];
      final sourceId = itemMap['id'] as String?;
      final isAdded = itemMap['isAdded'] as bool?;
      final articleMap = itemMap['article'] as Map<String, dynamic>?;
      print('ddddddddd $sourceId  :  $isAdded');

      if (sourceId != null && isAdded != null && articleMap != null) {
        ref
            .read(userBookmarksNotifierProvider.notifier)
            .toggleBookmarksFromState(
              Article.fromJson(articleMap),
              isAdded,
            );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await ref
            .read(userBookmarksNotifierProvider.notifier)
            .loadDataIfStateIsNull(widget.userId);
      } catch (e) {
        print(e);
      }
    });
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
      try {
        print(
            'userListenerProvider (BookmarksPage) about user Bookmarks-Article=====>');

        await userBookmarksProv.loadDataIfStateIsNull(now?.uid);
      } catch (e) {
        print(e);
      }
    });
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (wasPopped, result) async {
        try {
          print('Leaving...............');
          updateTheStateBeforeLeaving();
        } catch (e) {
          try {
            await userBookmarksProv.refreshUserBookmarksArticles(widget.userId);
          } catch (e) {
            AppAlerts.displaySnackBar(e.toString(), context);
          }
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
              Text(userBookmarksState!.length.toString()),
              const SizedBox(
                height: 30,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final article = userBookmarksState?[index];
                  if (article != null) {
                    return Column(
                      key: ValueKey(article.id),
                      children: [
                        Text(article.id),
                        const SizedBox(
                          height: 20,
                        ),
                        ToggleButton(
                          callback: (isExists) async {
                            try {
                              var item;
                              var indexInModified;

                              for (int i = 0;
                                  i < modifiedStateList.length;
                                  i++) {
                                if (modifiedStateList[i]['id'] == article.id) {
                                  item = modifiedStateList[i];
                                  indexInModified = i;
                                  break;
                                }
                              }

                              setState(() {
                                if (item == null) {
                                  modifiedStateList.add({
                                    'id': article.id,
                                    'isAdded': isExists,
                                    'article': article.toJson()
                                  });
                                } else {
                                  modifiedStateList[indexInModified] = {
                                    'id': article.id,
                                    'isAdded': isExists,
                                    'article': article.toJson()
                                  };
                                }
                              });

                              await userBookmarksProv
                                  .toggleBookmarkFromDataBase(
                                      article, widget.userId);
                              print(modifiedStateList);
                            } catch (e) {
                              setState(() {
                                modifiedStateList.clear();
                              });
                              rethrow;
                            }
                          },
                          onFailure: () async {
                            await userBookmarksProv
                                .refreshUserBookmarksArticles(widget.userId);
                          },
                        ),
                      ],
                    );
                  }

                  return const SizedBox();
                },
                separatorBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(15),
                  height: 2,
                  color: Colors.grey,
                ),
                itemCount: userBookmarksState?.length ?? 0,
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
