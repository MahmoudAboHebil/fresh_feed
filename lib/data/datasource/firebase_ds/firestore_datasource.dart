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

  // testing getUserFollowingChannels is done
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

  // testing toggleUserChannel() is done
  Future<Map<String, Object>> toggleUserChannel(
      String sourceId, String userUid) async {
    try {
      bool? isAdded;
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
          isAdded = false;
        } else {
          trans.set(
            docRef,
            {
              'sources': FieldValue.arrayUnion([sourceId]),
            },
            SetOptions(merge: true),
          );
          isAdded = true;
        }
      });
      return {
        'sourceId': sourceId,
        'isAdded': isAdded!,
      };
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

  Future<List<ViewModel>> getViewModelWhereInByIds(List<String> ids) async {
    try {
      List<ViewModel> allDocuments = [];
      // Split IDs into chunks of 10
      for (int i = 0; i < ids.length; i += 10) {
        final batchIds =
            ids.sublist(i, i + 10 > ids.length ? ids.length : i + 10);

        QuerySnapshot querySnapshot = await _firebaseService.firestore
            .collection('views')
            .where(FieldPath.documentId, whereIn: batchIds)
            .get();

        List<ViewModel> list = querySnapshot.docs
            .map((doc) {
              if (doc.exists && doc.data() != null) {
                return ViewModel.fromJson(doc.data() as Map<String, dynamic>);
              }
              return null;
            })
            .whereType<ViewModel>() // Filter out null values directly
            .toList();

        allDocuments.addAll(list);
      }
      allDocuments = allDocuments.toSet().toList();

      return allDocuments;
    } catch (e) {
      rethrow;
    }
  }

  // testing getArticlesViews is done
  Future<ViewModel?> getArticleViews(String articleId) async {
    try {
      final snap = await _firebaseService.firestore
          .collection('views')
          .doc(articleId)
          .get();
      if (snap.exists && snap.data() != null) {
        return ViewModel.fromJson(snap.data() as Map<String, Object?>);
      } else {
        return null;
      }
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

  Future<List<Map<String, Object>>> getArticlesCommentsWhereInByIds(
      List<String> articlesIds) async {
    try {
      List<Map<String, Object>> allDocuments = [];

      for (int i = 0; i < articlesIds.length; i += 10) {
        List<String> articlesBatch = articlesIds.sublist(
            i, i + 10 > articlesIds.length ? articlesIds.length : i + 10);

        QuerySnapshot querySnapshot = await _firebaseService.firestore
            .collection('artComments')
            .where(FieldPath.documentId, whereIn: articlesBatch)
            .get();

        List<Map<String, Object>> batchData = querySnapshot.docs
            .map(
              (snap) {
                final data = snap.data() as Map<String, dynamic>?;

                List<dynamic>? articleComments =
                    snap.exists ? (data?['comments']) : null;

                if (articleComments != null) {
                  final listOfCommentsModel = articleComments
                      .cast<String>()
                      .map((String letter) =>
                          CommentModel.fromJson(letter, snap.id))
                      .toList();
                  // ascending order
                  listOfCommentsModel
                      .sort((a, b) => a.dateTime.compareTo(b.dateTime));

                  return {
                    'articleId': snap.id,
                    'comments': listOfCommentsModel
                  };
                }
                return null;
              },
            )
            .whereType<Map<String, Object>>()
            .toList();
        allDocuments.addAll(batchData);
      }
      List<Map<String, Object>> uniqueDocuments = [];
      Set<String> seenArticleIDs = {};

      for (var article in allDocuments) {
        if (!seenArticleIDs.contains(article['articleId'])) {
          seenArticleIDs.add(article['articleId'] as String);
          uniqueDocuments.add(article);
        }
      }

      return uniqueDocuments;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CommentModel>> getArticleComments(String articleId) async {
    try {
      final snap = await _firebaseService.firestore
          .collection('artComments')
          .doc(articleId)
          .get();

      List<dynamic>? list = snap.exists ? (snap.data()?['comments']) : null;
      if (list != null) {
        return list
            .cast<String>()
            .map((String letter) => CommentModel.fromJson(letter, articleId))
            .toList();
      } else {
        return <CommentModel>[];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addArticleComment(CommentModel model) async {
    String letter = model.toJson(model);
    try {
      await _firebaseService.firestore
          .collection('artComments')
          .doc(model.articleId)
          .set(
        {
          'comments': FieldValue.arrayUnion([letter])
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteArtComment(CommentModel model) async {
    String letter = model.toJson(model);
    try {
      await _firebaseService.firestore
          .collection('artComments')
          .doc(model.articleId)
          .set(
        {
          'comments': FieldValue.arrayRemove([letter])
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateArtComment(
      String newMessage, CommentModel oldModel) async {
    try {
      await deleteArtComment(oldModel);
      await addArticleComment(oldModel.copyWith(comment: newMessage));
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
