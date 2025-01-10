import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

class ArticleViewNotifier extends Notifier<List<ViewModel>> {
  @override
  List<ViewModel> build() {
    return [];
  }

  // this function will be used in the dispose of any article page
  Future<void> addArticleView(String articleID, String userId) async {
    try {
      if (state.isEmpty) {
        await _refreshData();
      }

      bool isArticleViewExist;
      final articles = state;

      isArticleViewExist = articles.any(
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

        await ref
            .read(articleViewRepoProvider)
            .addArticleView(articleID, userId);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _refreshData() async {
    state = await ref.read(articleViewRepoProvider).getArticlesViews();
  }
}

final articleViewNotifierProvider =
    NotifierProvider<ArticleViewNotifier, List<ViewModel>>(() {
  return ArticleViewNotifier();
});
