import '../../../utils/app_exception.dart';
import '../../datasource/firebase_ds/firestore_datasource.dart';
import '../../models/comment_model.dart';

class ArticleCommentRepository {
  final FirestoreDatasource _firestoreDS;
  const ArticleCommentRepository(this._firestoreDS);

  //todo: you need to add methods about reply comments
  //todo: you need to add Stream

  Future<List<CommentModel>> getArticleComments(String articleId) async {
    try {
      final comments = await _firestoreDS.getArticleComments(articleId);

      return comments;
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to getting article comment ',
        methodInFile: 'getArticleComments()/ArticleCommentRepository',
        details: e.toString(),
      );
    }
  }

  Future<List<Map<String, Object>>> getArticlesCommentsWhereInByIds(
      List<String> articlesIds) async {
    try {
      final articlesComments =
          await _firestoreDS.getArticlesCommentsWhereInByIds(articlesIds);
      return articlesComments;
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to get articles comments ',
        methodInFile:
            'getArticlesCommentsWhereInByIds()/ArticleCommentRepository',
        details: e.toString(),
      );
    }
  }

  Future<void> updateArtComment(
      String? newMessage, CommentModel oldModel) async {
    try {
      await _firestoreDS.updateArtComment(
          newMessage: newMessage, oldModel: oldModel);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to update article comment ',
        methodInFile: 'updateArtComment()/ArticleCommentRepository',
        details: e.toString(),
      );
    }
  }

  Future<void> deleteArtComment(CommentModel model) async {
    try {
      await _firestoreDS.deleteArtComment(model);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to delete article comment ',
        methodInFile: 'deleteArtComment()/ArticleCommentRepository',
        details: e.toString(),
      );
    }
  }

  Future<void> addArticleComment(CommentModel model) async {
    try {
      await _firestoreDS.addArticleComment(model);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to add article comment ',
        methodInFile: 'addArticleComment()/ArticleCommentRepository',
        details: e.toString(),
      );
    }
  }

  //todo: you need to add methods about reply comments

  // version2 done
  Future<void> addArticleReplayComment(
      String parentId, CommentModel replayCom) async {
    try {
      await _firestoreDS.addArticleReplayComment(parentId, replayCom);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to add article replay comment ',
        methodInFile: 'addArticleReplayComment()/ArticleCommentRepository',
        details: e.toString(),
      );
    }
  }

  // version2 done
  Stream<List<CommentModel>> streamArticleReplayComments(
      String articleId, String parentId) {
    try {
      return _firestoreDS.streamArticleReplayComments(articleId, parentId);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to get article replay comment ',
        methodInFile: 'streamArticleReplayComments()/ArticleCommentRepository',
        details: e.toString(),
      );
    }
  }

  // version2 done
  Future<List<CommentModel>> getArticleReplayComments(
      String articleId, String parentId) async {
    try {
      return _firestoreDS.getArticleReplayComments(articleId, parentId);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to get article replay comment ',
        methodInFile: 'getArticleReplayComments()/ArticleCommentRepository',
        details: e.toString(),
      );
    }
  }

  // version2 done
  Future<void> deleteArtReplayComment(
      CommentModel model, String parentId) async {
    try {
      return _firestoreDS.deleteArtReplayComment(model, parentId);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to delete article replay comment ',
        methodInFile: 'deleteArtReplayComment()/ArticleCommentRepository',
        details: e.toString(),
      );
    }
  }

  // version2 done
  Future<void> updateArtReplayComment({
    String? newMessage,
    required String parentId,
    required CommentModel oldModel,
  }) async {
    try {
      return _firestoreDS.updateArtReplayComment(
          newMessage: newMessage, parentId: parentId, oldModel: oldModel);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to update article replay comment ',
        methodInFile: 'updateArtReplayComment()/ArticleCommentRepository',
        details: e.toString(),
      );
    }
  }
}
