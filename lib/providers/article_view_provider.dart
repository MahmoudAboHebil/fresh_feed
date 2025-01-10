import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

// i didn't use the state as future to manipulate the state date
// to minimize network cost of "get" data
class ArticleViewNotifier extends Notifier<List<ViewModel>?> {
  @override
  List<ViewModel>? build() {
    return null;
  }

  // this function will be called at the initSate of any article page
  Future<void> addArticleViewToDataBase(String articleID, String userId) async {
    try {
      await loadDataIfStateIsNull();

      bool isArticleViewExist;
      final articles = state;

      isArticleViewExist = articles!.any(
        (art) => art.articleId == articleID && art.usersId.contains(userId),
      );

      if (!isArticleViewExist) {
        await ref
            .read(articleViewRepoProvider)
            .addArticleView(articleID, userId);
      }
    } catch (e) {
      rethrow;
    }
  }

  // this function will be called when leaving the article page
  void addArticleViewToState(String articleID, String userId) {
    try {
      if (state == null) return;

      bool isArticleViewExist;
      final articles = state;

      isArticleViewExist = articles!.any(
        (art) => art.articleId == articleID && art.usersId.contains(userId),
      );

      if (!isArticleViewExist) {
        final isArticleExist =
            articles.any((art) => art.articleId == articleID);
        if (isArticleExist) {
          final oldUsersIdList =
              articles.firstWhere((art) => art.articleId == articleID).usersId;
          final newUsersIdList = [...oldUsersIdList, userId];

          final articleListRemoved =
              articles.where((art) => art.articleId != articleID).toList();
          final newArticleView = [
            ...articleListRemoved,
            ViewModel(articleId: articleID, usersId: newUsersIdList)
          ];
          state = newArticleView;
        } else {
          final newArticleView = [
            ...articles,
            ViewModel(articleId: articleID, usersId: [userId])
          ];
          state = newArticleView;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshData() async {
    try {
      state = await ref.read(articleViewRepoProvider).getArticlesViews();
    } catch (e) {
      state = null;
      rethrow;
    }
  }

  // you need call this function at the top level of articles
  Future<void> loadDataIfStateIsNull() async {
    try {
      if (state == null) {
        refreshData();
      }
    } catch (e) {
      state = null;
      rethrow;
    }
  }
}

final articleViewNotifierProvider =
    NotifierProvider<ArticleViewNotifier, List<ViewModel>?>(() {
  return ArticleViewNotifier();
});
