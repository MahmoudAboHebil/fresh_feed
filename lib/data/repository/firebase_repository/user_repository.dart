import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_feed/data/datasource/datasource.dart';

import '../../../utils/utlis.dart';
import '../../models/models.dart';

class UserRepository {
  final FirestoreDatasource _firestoreDS;
  UserRepository(this._firestoreDS);

  Future<void> saveUserData(UserModel user) async {
    try {
      await _firestoreDS.saveUserData(user);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! saving user data  failed',
        methodInFile: 'saveUserData()/UserRepository',
        details: e.toString(),
      );
    }
  }

  Stream<UserModel?> getUserStream(String uid) {
    try {
      return _firestoreDS.getUserStream(uid);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! getting user stream  failed',
        methodInFile: 'getUserStream()/UserRepository',
        details: e.toString(),
      );
    }
  }

  Future<void> updateUser(User user, AuthProviderType provider) async {
    try {
      await _firestoreDS.updateUser(user, provider);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! updating user data  failed',
        methodInFile: 'updateUser()/UserRepository',
        details: e.toString(),
      );
    }
  }
}
