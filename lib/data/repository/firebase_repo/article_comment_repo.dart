import '../../../utils/app_exception.dart';
import '../../datasource/firebase_ds/firestore_datasource.dart';
import '../../models/comment_model.dart';

class ArticleCommentRepository {
  final FirestoreDatasource _firestoreDS;
  const ArticleCommentRepository(this._firestoreDS);

  Future<List<CommentModel>> getArticleComments(String articleId) async {
    try {
      final comments = await _firestoreDS.getArticleComments(articleId);
      // ascending order
      comments.sort((a, b) => a.dateTime.compareTo(b.dateTime));
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
      String newMessage, CommentModel oldModel) async {
    try {
      await _firestoreDS.updateArtComment(newMessage, oldModel);
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
}
