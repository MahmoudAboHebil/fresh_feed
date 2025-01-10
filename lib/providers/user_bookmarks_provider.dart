import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

class UserBookmarksNotifier extends Notifier<List<Article>?> {
  @override
  List<Article>? build() {
    return null;
  }

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

  Future<void> toggleBookmarkFromDataBase(
      Article article, String userUid) async {
    try {
      final bookmarksRepo = ref.read(userBookmarksRepoProvider);
      await bookmarksRepo.toggleBookmarkArticle(article, userUid);
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
  }

  // you need call this function at the top level of articles
  Future<void> loadDataIfStateIsNull(String userUid) async {
    try {
      if (state == null) {
        await refreshUserBookmarksArticles(userUid);
      }
    } catch (e) {
      state = null;
      rethrow;
    }
  }
}
