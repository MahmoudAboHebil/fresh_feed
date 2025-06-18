import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

/// note : i will use Stream instead of using this provider state

/// is not best practicing  to load all the article that a lot  of them that user
/// will not use so it can be lead to overloading data .so, i will get each article
/// view that user visited it and cashed on this ArticleViewNotifier provider

/*
  Errors scenarios:
  1. Error in getArticleView()
     i. the state will be null and do not throw any error
    ii. addArticleView() => it will added to db and the state successfully

  2. Error in addArticleView()
      i. article do not add to DB and throw an error
     ii. getArticleView() => it will continue get the the state successfully
 */

class ArticleViewNotifier extends Notifier<List<ViewModel>?> {
  @override
  List<ViewModel>? build() {
    return null;
  }

  // when return null it means that 0 views
  Future<ViewModel?> getArticleView(String articleId) async {
    /*
      state == null
        *. getArticleView form DB
            if article is null
               i. return null
            else
              i. update the state
             ii. return the model

      state !=null
        1. state is not include this article
          *. getArticleView form DB
              if article is null
                 i. return null
              else
                 i. update the state
                ii. return the model
        2. state is include this article
               i. return the model
      */
    try {
      final viewProv = ref.read(articleViewRepoProvider);

      if (state == null) {
        final articleView = await viewProv.getArticlesViews(articleId);
        if (articleView == null) return null;

        state = [articleView];
        return articleView;
      }

      final isArticleExist = state!.any((mod) => mod.articleId == articleId);
      if (!isArticleExist) {
        final articleView = await viewProv.getArticlesViews(articleId);

        if (articleView == null) return null;

        state = [...state!, articleView];
        return articleView;
      }

      return state!.firstWhere((mod) => mod.articleId == articleId);
    } catch (e) {
      return null;
    }
  }

  Future<List<ViewModel>> getArticleViewsWhereInByIds(List<String> ids) async {
    try {
      List<String> uniqueIDS = [];
      List<String> stateIds =
          state?.map((mode) => mode.articleId).toList() ?? [];
      for (String id in ids) {
        if (!stateIds.contains(id)) {
          uniqueIDS.add(id);
        }
      }

      if (uniqueIDS.isEmpty) {
        return [];
      }
      final viewProv = ref.read(articleViewRepoProvider);
      print('${uniqueIDS.length}===============================>ids');

      final views = await viewProv.getViewModelWhereInByIds(uniqueIDS);
      print('${views.length}===============================>views');

      if (state != null) {
        final newList = [...state!, ...views];
        final uniqueList = newList.toSet().toList();
        state = [...uniqueList];
      } else {
        state = [...views];
      }
      return state ?? [];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addArticleView(String articleId, String userId) async {
    /*

      if state is is not include this user view model
          1. add user article view in db
          2. update the state
     else return;

     note: the reason why i just did not add to db and get from db and update
      the state, that i want not to do extra operation on db and that is the reason
      why i am using oldModel argument
     */
    try {
      final isExist =
          state?.any((mode) => mode.articleId == articleId) ?? false;
      final oldView = isExist
          ? state?.firstWhere((mode) => mode.articleId == articleId)
          : null;

      final viewProv = ref.read(articleViewRepoProvider);
      final isArticleExist =
          state?.any((mod) => mod.articleId == articleId) ?? false;
      final ViewModel? article;
      if (isArticleExist) {
        article = state?.firstWhere((mod) => mod.articleId == articleId);
      } else {
        article = null;
      }
      final isUserExist = article?.usersId.contains(userId) ?? false;

      if (isUserExist) {
        return;
      }

      await viewProv.addArticleView(articleId, userId);

      if (state == null) {
        if (oldView != null) {
          state = [
            ViewModel(
                articleId: articleId, usersId: [...oldView.usersId, userId])
          ];
        } else {
          final model = await viewProv.getArticlesViews(articleId);
          state = [model!];
        }
        return;
      }

      if (oldView != null) {
        final excludeList =
            state!.where((mod) => mod.articleId != oldView.articleId).toList();
        final newModel = ViewModel(
            articleId: articleId, usersId: [...oldView.usersId, userId]);
        state = [...excludeList, newModel];
        return;
      }

      if (article == null) {
        final art = await viewProv.getArticlesViews(articleId);
        state = [...state!, art!];
        return;
      }

      final excludeList =
          state!.where((mod) => mod.articleId != articleId).toList();
      final newModel = ViewModel(
          articleId: articleId, usersId: [...article.usersId, userId]);
      state = [...excludeList, newModel];
    } catch (e) {
      rethrow;
    }
  }
  /*

// i didn't use the state as future to manipulate the state date
// to minimize network cost of "get" data

/*
  Errors scenarios:
  1. Error in loadDataIfStateIsNull() or refreshData()
     i. the state will be null and throw an error
    ii. addArticleViewToDataBase() => it will throw an error
   iii. addArticleViewToState () => no thing happen

  2. Error in addArticleViewToDataBase()
      i. throw an error
     ii. addArticleViewToState() => will not be called

  3. Error in addArticleViewToState()
      i. we will just refresh the state
 */

  // this function will be called at the initSate of any article page
  // testing addArticleViewToDataBase is done
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
      print('addArticleViewToDataBase ===========================> success');
    } catch (e) {
      rethrow;
    }
  }

  // this function will be called when leaving the article page
  // (ensure that you called, there is problem with PushReplacement()
  // testing addArticleViewToState() is done
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
      print('Adding Article To the State');
      print('State $state ======================>');
    } catch (e) {
      rethrow;
    }
  }

  // testing refreshData() is done
  Future<void> refreshData() async {
    try {
      state = await ref.read(articleViewRepoProvider).getArticlesViews();
    } catch (e) {
      state = null;
      rethrow;
    }
  }

  // you need call this function at the top level of articles
  // testing loadDataIfStateIsNull() is done
  Future<void> loadDataIfStateIsNull() async {
    try {
      if (state == null) {
        await refreshData();
      }
    } catch (e) {
      state = null;
      rethrow;
    }
  }

   */
}

final articleViewNotifierProvider =
    NotifierProvider<ArticleViewNotifier, List<ViewModel>?>(() {
  return ArticleViewNotifier();
});
