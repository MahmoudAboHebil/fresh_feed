import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_feed/data/models/models.dart';
import 'package:fresh_feed/data/services/services.dart';
import 'package:fresh_feed/utils/utlis.dart';
/*
With transactions, Firestore ensures:
Atomicity:
All operations in the transaction succeed or fail together. If one part fails, the entire transaction is rolled back.

Consistency:
The data you read at the start of the transaction remains consistent throughout the transaction. If another process modifies the data, your transaction retries with the latest version of the data.

Automatic Conflict Resolution:
If Firestore detects a conflict (e.g., another process modifies the data you’re reading), the transaction automatically retries up to 5 times.

No Race Conditions:
Transactions lock the document while they are running, preventing other processes from modifying the same document until the transaction completes.
*/

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

  // testing getUserBookmarksArticles is done
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

  // testing toggleBookmarkArticle() is done
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

  Future<List<String>> getUserFollowingChannels(String userUid) async {
    try {
      final querySnap = await _firebaseService.firestore
          .collection('channels')
          .doc(userUid)
          .get();

      if (!querySnap.exists) {
        return <String>[];
      }

      final data = querySnap.data();
      if (data == null || data['sources'] == null) {
        return <String>[];
      }

      final sources = List<String>.from(data['sources'] as List);
      return sources;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleUserChannel(String sourceId, String userUid) async {
    try {
      final docRef =
          _firebaseService.firestore.collection('channels').doc(userUid);

      await _firebaseService.firestore.runTransaction((trans) async {
        final snap = await trans.get(docRef);

        final List<dynamic>? sources =
            snap.exists ? (snap.data()?['sources']) : null;

        final bool isChannelExists =
            sources != null && sources.cast<String>().contains(sourceId);

        if (isChannelExists) {
          trans.set(
            docRef,
            {
              'sources': FieldValue.arrayRemove([sourceId]),
            },
            SetOptions(merge: true),
          );
        } else {
          trans.set(
            docRef,
            {
              'sources': FieldValue.arrayUnion([sourceId]),
            },
            SetOptions(merge: true),
          );
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

  // testing getArticlesViews is done
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

  // testing addArticleView() is done
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
