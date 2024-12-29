import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_feed/data/models/models.dart';
import 'package:fresh_feed/data/services/services.dart';
import 'package:fresh_feed/utils/utlis.dart';

class FirestoreDatasource {
  FirestoreDatasource(this._firebaseService);
  final FirebaseService _firebaseService;

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

  Stream<UserModel?> getUserStream(String uid) {
    try {
      return _firebaseService.firestore
          .collection('users')
          .doc(uid)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          return UserModel.fromJson(snapshot.data()!);
        }
        return null;
      });
    } catch (e) {
      rethrow;
    }
  }

  // for sign in and sign up
  Future<void> updateUser(User user, AuthProviderType provider) async {
    final userModel = UserModel(
      uid: user.uid,
      email: user.email,
      phoneNumber: user.phoneNumber,
      name: user.displayName.toString(),
      profileImageUrl: user.photoURL,
      emailVerified: user.emailVerified,
      phoneVerified: user.phoneNumber != null,
      authProvider: provider,
    );
    await saveUserData(userModel);
  }
}
