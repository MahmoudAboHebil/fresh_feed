import '../../../utils/app_exception.dart';
import '../../datasource/firebase_ds/firestore_datasource.dart';
import '../../models/news_models/news_article.dart';

class UserBookmarksRepository {
  final FirestoreDatasource _firestoreDS;

  const UserBookmarksRepository(this._firestoreDS);

  // testing toggleBookmarkArticle() is done
  Future<void> toggleBookmarkArticle(Article article, String userUid) async {
    try {
      await _firestoreDS.toggleBookmarkArticle(article, userUid);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! An error occurred about saving data. Please try again.',
        methodInFile: 'toggleBookmarkArticle()/UserBookmarksRepository',
        details: e.toString(),
      );
    }
  }

  // testing getUserBookmarksArticles is done
  Future<List<Article>> getUserBookmarksArticles(String userUid) async {
    try {
      return await _firestoreDS.getUserBookmarksArticles(userUid);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to get bookmarks articles ',
        methodInFile: 'getUserBookmarksArticles()/UserBookmarksRepository',
        details: e.toString(),
      );
    }
  }
}
