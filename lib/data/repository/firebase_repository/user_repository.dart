import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_feed/data/data.dart';

import '../../../utils/utlis.dart';

class UserRepository {
  final FirestoreDatasource _firestoreDS;

  UserRepository(this._firestoreDS);

  // testing saveUserData is done
  Future<void> saveUserData(UserModel user) async {
    try {
      await _firestoreDS.saveUserData(user);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! saving user data is failed',
        methodInFile: 'saveUserData()/UserRepository',
        details: e.toString(),
      );
    }
  }

  Stream<UserModel?> getUserStream(
    String uid,
  ) {
    try {
      final userModel = _firestoreDS.getUserStream(uid);
      return userModel;
    } catch (e) {
      print('getUserStream()/UserRepository');

      // AppAlerts.displaySnackBar('Oops! getting user data is failed', context);

      throw FreshFeedException(
        message: 'Oops! getting user data is  failed',
        methodInFile: 'getUserStream()/UserRepository',
        details: e.toString(),
      );
    }
  }

  // test getUserData is done
  Future<UserModel?> getUserData(String uid) async {
    try {
      return await _firestoreDS.getUserData(uid);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! getting user data is  failed',
        methodInFile: 'getUserData()/UserRepository',
        details: e.toString(),
      );
    }
  }

  // test updateUser done
  Future<void> updateUser(User user, AuthProviderType provider,
      {String? username}) async {
    try {
      await _firestoreDS.updateUser(user, provider, username);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! updating user data is failed',
        methodInFile: 'updateUser()/UserRepository',
        details: e.toString(),
      );
    }
  }
}
