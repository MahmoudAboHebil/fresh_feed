import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/comment_model.dart';
import '../data/repository/firebase_repo/article_comment_repo_provider.dart';

/// is not best practicing  to load all the article that a lot  of them that user
/// will not use so it can be lead to overloading data .so, i will get each article
/// comment that user visited it and cashed on this ArticleCommentNotifier provider

/*
  Errors scenarios:
  1.Error in getArticlesCommentsWhereInByIds(), getArticleComments(),
    addArticleComment(), deleteArtComment() && updateArtComment()
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

  Future<List<CommentModel>> getArticleComments(String articleId) async {
    try {
      final commentRepoProv = ref.read(articleCommentRepoProvider);
      final isArticleExist = state != null &&
          state!.any((mod) => mod['articleId'] as String == articleId);
      if (!isArticleExist) {
        final artComments = await commentRepoProv.getArticleComments(articleId);
        if (artComments.isNotEmpty) {
          final art = {'articleId': articleId, 'comments': artComments};
          state = (state != null) ? [...state!, art] : [art];
        }
        return artComments;
      }

      return state!.firstWhere(
              (mod) => mod['articleId'] as String == articleId)['comments']
          as List<CommentModel>;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addArticleComment(CommentModel model) async {
    try {
      final commentRepoProv = ref.read(articleCommentRepoProvider);
      await commentRepoProv.addArticleComment(model);
      final isArticleExist = state != null &&
          state!.any((mod) => mod['articleId'] as String == model.articleId);
      if (!isArticleExist) {
        final art = {
          'articleId': model.articleId,
          'comments': [model]
        };
        state = (state != null) ? [...state!, art] : [art];
        return;
      }

      var artStateComments = state!.firstWhere((mod) =>
              mod['articleId'] as String == model.articleId)['comments']
          as List<CommentModel>;
      artStateComments.add(model);
      artStateComments = artStateComments.toSet().toList();
      artStateComments.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      final art = {'articleId': model.articleId, 'comments': artStateComments};
      final excludeState = state
          ?.where((mod) => mod['articleId'] as String != model.articleId)
          .toList();

      state = [...excludeState!, art];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteArtComment(CommentModel model) async {
    try {
      final commentRepoProv = ref.read(articleCommentRepoProvider);
      await commentRepoProv.deleteArtComment(model);

      var artStateComments = state!.firstWhere((mod) =>
              mod['articleId'] as String == model.articleId)['comments']
          as List<CommentModel>;
      artStateComments.remove(model);
      artStateComments.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      final art = {'articleId': model.articleId, 'comments': artStateComments};
      final excludeState = state
          ?.where((mod) => mod['articleId'] as String != model.articleId)
          .toList();

      state = [...excludeState!, art];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateArtComment(
      String newMessage, CommentModel oldModel) async {
    try {
      final commentRepoProv = ref.read(articleCommentRepoProvider);
      await commentRepoProv.updateArtComment(newMessage, oldModel);

      final newModel = oldModel.copyWith(comment: newMessage);

      var artStateComments = state!.firstWhere((mod) =>
              mod['articleId'] as String == oldModel.articleId)['comments']
          as List<CommentModel>;

      artStateComments.remove(oldModel);
      artStateComments.add(newModel);
      artStateComments = artStateComments.toSet().toList();
      artStateComments.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      final art = {
        'articleId': newModel.articleId,
        'comments': artStateComments
      };
      final excludeState = state
          ?.where((mod) => mod['articleId'] as String != oldModel.articleId)
          .toList();

      state = [...excludeState!, art];
    } catch (e) {
      rethrow;
    }
  }
}

final articleCommentProvider =
    NotifierProvider<ArticleCommentNotifier, List<Map<String, Object>>?>(() {
  return ArticleCommentNotifier();
});
