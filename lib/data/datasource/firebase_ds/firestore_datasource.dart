import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_feed/data/models/models.dart';
import 'package:fresh_feed/data/services/services.dart';
import 'package:fresh_feed/utils/utlis.dart';

class FirestoreDatasource {
  FirestoreDatasource(this._firebaseService);
  final FirebaseService _firebaseService;

  // test saveUserData is done
  Future<void> saveUserData(UserModel user) async {
    try {
      // for updating the fields that changed only and leave the rest without change
      // for creating new doc if it is not exists
      await _firebaseService.firestore.collection('users').doc(user.uid).set(
            user.toJson(),
            SetOptions(merge: true),
          );
      /*
      for updating the enter doc with the new one (replace all)
      for creating new doc if it is not exists
      await _firebaseService.firestore.collection('users').doc(user.uid).set(
            user.toJson(),
          );

      for updating the fields that changed only and leave the rest without change
      throwing an error if the doc does not exists
      await _firebaseService.firestore.collection('users').doc(user.uid).update(
            user.toJson(),
          );
       */
    } catch (e) {
      rethrow;
    }
  }

  // test getUserData is done
  Future<UserModel?> getUserData(String uid) async {
    try {
      final userDoc =
          await _firebaseService.firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return UserModel.fromJson(userDoc.data()!);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // testing getUserStream is done
  Stream<UserModel?> getUserStream(String uid) async* {
    try {
      await for (final snapshot in _firebaseService.firestore
          .collection('users')
          .doc(uid)
          .snapshots()) {
        if (snapshot.exists) {
          yield UserModel.fromJson(snapshot.data()!);
        } else {
          yield null;
        }
      }
    } catch (e) {
      yield null;
    }
  }

  Future<List<Article>> getUserBookmarksArticles(String userUid) async {
    try {
      final querySnap = await _firebaseService.firestore
          .collection('bookmarks')
          .doc(userUid)
          .collection('articles')
          .get();
      return querySnap.docs
          .map((doc) => Article.fromJson(doc.data() as Map<String, Object?>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleBookmarkArticle(Article article, String userUid) async {
    try {
      final docRef = _firebaseService.firestore
          .collection('bookmarks')
          .doc(userUid)
          .collection('articles')
          .doc(article.id);

      // i use runTransaction to perform atomic and consistent
      // read-write operations on one
      await _firebaseService.firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);
        if (snapshot.exists) {
          transaction.delete(docRef);
        } else {
          transaction.set(docRef, article.toJson());
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ViewModel>> getArticlesViewsStream() async* {
    try {
      await for (final snapshot
          in _firebaseService.firestore.collection('views').snapshots()) {
        final views =
            snapshot.docs.map((doc) => ViewModel.fromJson(doc.data())).toList();
        yield views;
      }
    } catch (e) {
      yield [];
    }
  }

  Future<List<ViewModel>> getArticlesViews() async {
    try {
      final querySnap =
          await _firebaseService.firestore.collection('views').get();
      return querySnap.docs
          .map((doc) => ViewModel.fromJson(doc.data() as Map<String, Object?>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addArticleView(String articleID, String userId) async {
    try {
      await _firebaseService.firestore.collection('views').doc(articleID).set(
        {
          'articleId': articleID,
          'usersId': FieldValue.arrayUnion([userId]),
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      rethrow;
    }
  }

  // test updateUser is done
  // for sign in and sign up
  Future<void> updateUser(
      User user, AuthProviderType provider, String? userName) async {
    try {
      final userModel = UserModel(
        uid: user.uid,
        email: user.email,
        phoneNumber: user.phoneNumber,
        name: userName ?? user.displayName.toString(),
        profileImageUrl: user.photoURL,
        emailVerified: user.emailVerified,
        phoneVerified: user.phoneNumber != null,
        authProvider: provider,
      );
      await saveUserData(userModel);
    } catch (e) {
      rethrow;
    }
  }
}
