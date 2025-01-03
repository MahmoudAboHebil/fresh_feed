import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_feed/data/models/models.dart';
import 'package:fresh_feed/data/services/services.dart';
import 'package:fresh_feed/utils/utlis.dart';

class FirestoreDatasource {
  FirestoreDatasource(this._firebaseService);
  final FirebaseService _firebaseService;

  Future<void> updateUserEmailVerification(User user) async {
    try {
      if (user.emailVerified) {
        await _firebaseService.firestore
            .collection('users')
            .doc(user.uid)
            .update({
          'emailVerified': true,
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  // test saveUserData is done
  Future<void> saveUserData(UserModel user) async {
    try {
      await _firebaseService.firestore.collection('users').doc(user.uid).set(
            user.toJson(),
            SetOptions(merge: true),
          );
    } catch (e) {
      rethrow;
    }
  }

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

  // test updateUser is done
  // for sign in and sign up
  Future<void> updateUser(
      User user, AuthProviderType provider, String? userName) async {
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
  }
}
