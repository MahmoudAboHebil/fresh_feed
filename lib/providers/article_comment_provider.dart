import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repository/firebase_repo/article_comment_repo_provider.dart';

/// is not best practicing  to load all the article that a lot  of them that user
/// will not use so it can be lead to overloading data .so, i will get each article
/// comment that user visited it and cashed on this ArticleCommentNotifier provider

/*
  Errors scenarios:
  1.Error in getArticlesCommentsWhereInByIds()
     i. throw an error to the user
    ii. the state will not be effected

 */

class ArticleCommentNotifier extends Notifier<List<Map<String, Object>>?> {
  @override
  List<Map<String, Object>>? build() {
    return null;
  }

  Future<List<Map<String, Object>>> getArticlesCommentsWhereInByIds(
      List<String> articlesIds) async {
    try {
      List<String> uniqueIDS = [];
      List<String> stateIds =
          state?.map((mode) => mode['articleId'] as String).toList() ?? [];

      for (String id in articlesIds) {
        if (!stateIds.contains(id)) {
          uniqueIDS.add(id);
        }
      }
      if (uniqueIDS.isEmpty) {
        return [];
      }
      print('${uniqueIDS.length}===============================>ids');

      final commentRepoProv = ref.read(articleCommentRepoProvider);
      final articlesComments =
          await commentRepoProv.getArticlesCommentsWhereInByIds(uniqueIDS);
      print('${articlesComments.length}===============================>views');

      if (state != null) {
        state = [...state!, ...articlesComments];
        // there are not duplicated to the state data with help of uniqueIDS list
        // so there is no need to make this process
      } else {
        state = [...articlesComments];
      }
      return articlesComments;
    } catch (e) {
      rethrow;
    }
  }
}

final articleCommentProvider =
    NotifierProvider<ArticleCommentNotifier, List<Map<String, Object>>?>(() {
  return ArticleCommentNotifier();
});
