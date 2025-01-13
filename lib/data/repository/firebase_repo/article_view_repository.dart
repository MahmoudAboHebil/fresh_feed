import '../../../utils/app_exception.dart';
import '../../datasource/firebase_ds/firestore_datasource.dart';
import '../../models/view_model.dart';

class ArticleViewRepository {
  final FirestoreDatasource _firestoreDS;

  const ArticleViewRepository(this._firestoreDS);

  // testing addArticleView() is done
  Future<void> addArticleView(String articleID, String userId) async {
    try {
      await _firestoreDS.addArticleView(articleID, userId);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to adding article view ',
        methodInFile: 'addArticleView()/ArticleViewRepository',
        details: e.toString(),
      );
    }
  }

  // testing getArticlesViews() is done
  Future<List<ViewModel>> getArticlesViews() async {
    try {
      return await _firestoreDS.getArticlesViews();
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to get article views ',
        methodInFile: 'getArticlesViews()/ArticleViewRepository',
        details: e.toString(),
      );
    }
  }
}
