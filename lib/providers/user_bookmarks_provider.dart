import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

class UserBookmarksNotifier extends Notifier<List<Article>?> {
  @override
  List<Article>? build() {
    return null;
  }

  // testing refreshUserBookmarksArticles() is done
  Future<void> refreshUserBookmarksArticles(String userUid) async {
    try {
      final bookmarksRepo = ref.read(userBookmarksRepoProvider);
      final newState = await bookmarksRepo.getUserBookmarksArticles(userUid);
      state = newState;
    } catch (e) {
      state = null;
      rethrow;
    }
  }

  // testing toggleBookmarkFromDataBase() is done
  Future<void> toggleBookmarkFromDataBase(
      Article article, String userUid) async {
    try {
      await loadDataIfStateIsNull(userUid);

      final bookmarksRepo = ref.read(userBookmarksRepoProvider);
      await bookmarksRepo.toggleBookmarkArticle(article, userUid);
      print('toggleBookmarkFromDataBase success====================>');
    } catch (e) {
      rethrow;
    }
  }

  // use toggleBookmarksFromState() for remove bookmarks article from
  // the ui Right away
  // 1. At the top bookmarks page : It is called  when taping toggle
  //    button after calling toggleBookmarkFromDataBase().
  // 2. At the the article page: It is called when leaving this page and
  //    toggleBookmarkFromDataBase() will be called at the toggle button
  //testing toggleBookmarksFromState() is done
  void toggleBookmarksFromState(Article article, bool add) {
    if (!add) {
      if (state == null) return;

      //remove
      final updateState = state!.where((art) => art.id != article.id).toList();
      state = [...updateState];
    } else {
      //add
      final isExists = state?.any((art) => art.id == article.id) ?? false;
      if (!isExists) {
        if (state != null) {
          state = [...state!, article];
        } else {
          state = [article];
        }
      }
    }

    print('toggleBookmarksFromState success====================>$add');
  }

  // you need call this function at the top level of articles
  // testing loadDataIfStateIsNull() is done
  Future<void> loadDataIfStateIsNull(String? userUid) async {
    try {
      if (userUid != null) {
        if (state == null) {
          await refreshUserBookmarksArticles(userUid);
        }
      } else {
        state = null;
      }
      print('UserBookmarks state: $state');
    } catch (e) {
      state = null;
      rethrow;
    }
  }

/*
   Errors seniors:
   1. Error in refreshUserBookmarksArticles() or loadDataIfStateIsNull()
      1. the state will be null
      2. the toggleBookmarksFromState() it will do no thing
      3. toggleBookmarkFromDataBase() =>  it will throw an Error but we must force
         the user to do not that by disappearing the toggle button and showing
         an alert message to him when he entre the home page tha article page starts with
         help of ref.listen()///TODO

   2. Error toggleBookmarksFromState()
      1. when leaving the bookmarks page we refresh the state without
         showing the error because the update date will get from the DB
      2. at the article page we refresh the state and showing the error
         because we the old data will get from the DB and nothing will change
         due that the toggleBookmarkFromDataBase() will not called


   3. Error in toggleBookmarkFromDataBase()
      1. it will throw an error
      2. at user bookmarks Page && the article page  we will make a logic that
         it will refresh the state if this error happen to get the correct data from database

 */
}

final userBookmarksNotifierProvider =
    NotifierProvider<UserBookmarksNotifier, List<Article>?>(() {
  return UserBookmarksNotifier();
});
