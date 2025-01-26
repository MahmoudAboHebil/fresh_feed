import '../../../utils/app_exception.dart';
import '../../datasource/firebase_ds/firestore_datasource.dart';
import '../../models/view_model.dart';

class ArticleViewRepository {
  final FirestoreDatasource _firestoreDS;

  const ArticleViewRepository(this._firestoreDS);

  // testing addArticleView() is done
  Future<void> addArticleView(String articleID, String userId) async {
    try {
      print('Add Article View From DB');

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
  Future<ViewModel?> getArticlesViews(String articleId) async {
    try {
      print('Get Article View From DB');

      return await _firestoreDS.getArticleViews(articleId);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to get article views ',
        methodInFile: 'getArticlesViews()/ArticleViewRepository',
        details: e.toString(),
      );
    }
  }

  Future<List<ViewModel>> getViewModelWhereInByIds(List<String> ids) async {
    try {
      print('Get View model using where');

      return await _firestoreDS.getViewModelWhereInByIds(ids);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! failed to get article views ',
        methodInFile: 'getViewModelWhereInByIds()/ArticleViewRepository',
        details: e.toString(),
      );
    }
  }
}
