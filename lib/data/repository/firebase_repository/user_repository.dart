import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresh_feed/data/datasource/datasource.dart';

import '../../../utils/utlis.dart';
import '../../models/models.dart';

class UserRepository {
  final FirestoreDatasource _firestoreDS;
  UserRepository(this._firestoreDS);

  Future<void> saveUserData(UserModel user, BuildContext context) async {
    try {
      await _firestoreDS.saveUserData(user);
    } catch (e) {
      AppAlerts.displaySnackBar('Oops! saving user data is failed', context);

      throw FreshFeedException(
        message: 'Oops! saving user data is failed',
        methodInFile: 'saveUserData()/UserRepository',
        details: e.toString(),
      );
    }
  }

  Stream<UserModel?> getUserStream(String uid, BuildContext context) {
    try {
      return _firestoreDS.getUserStream(uid);
    } catch (e) {
      AppAlerts.displaySnackBar('Oops! getting user data is failed', context);

      throw FreshFeedException(
        message: 'Oops! getting user data is  failed',
        methodInFile: 'getUserStream()/UserRepository',
        details: e.toString(),
      );
    }
  }

  Future<void> updateUser(
      User user, AuthProviderType provider, BuildContext context) async {
    try {
      await _firestoreDS.updateUser(user, provider);
    } catch (e) {
      AppAlerts.displaySnackBar('Oops! updating user data is failed', context);
      throw FreshFeedException(
        message: 'Oops! updating user data is failed',
        methodInFile: 'updateUser()/UserRepository',
        details: e.toString(),
      );
    }
  }
}
