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
    if (state == null) return;
    if (!add) {
      //remove
      final updateState = state!.where((art) => art.id != article.id).toList();
      state = [...updateState];
    } else {
      //add
      state = [...state!, article];
    }
    print('toggleBookmarksFromState success====================>');
    print(state);
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
      print(state);
    } catch (e) {
      state = null;
      rethrow;
    }
  }

/*
  Errors scenarios:
  1. Error in loadDataIfStateIsNull()
      i. the state will be null
     ii. toggleBookmarkFromDataBase() =>  will toggle successfully but we must force
         the user to do not that by disappearing the toggle button and showing
         an alert message to him when he entre the home page tha article page starts with
         help of ref.listen()///TODO

    iii. toggleBookmarksFromState() =>  no thing happen to the state

  2. Error in toggleBookmarkFromDataBase() =>An alert message will displayed to him
      i. the state will still as it
     ii. toggleBookmarksFromState() => will toggle the state successfully


  3. Error in toggleBookmarksFromState() that happen if there is a problem with
     handling the state data
     i. if it used when leaving article page and the toggleBookmarkFromDataBase()
        is called => the data will saved correctly to the database and whenever he
        start up the app he will get the new data .But, when using the app with this
        problem the state will not updated and the user he will not notice any changes
        whenever he comes to the same article


 */
}

final userBookmarksNotifierProvider =
    NotifierProvider<UserBookmarksNotifier, List<Article>?>(() {
  return UserBookmarksNotifier();
});
