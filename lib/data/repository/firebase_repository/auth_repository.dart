import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_feed/data/datasource/firebase_datasource/auth_datasource.dart';
import 'package:fresh_feed/utils/utlis.dart';

class AuthRepository {
  final AuthDataSource _authDataSource;

  const AuthRepository(this._authDataSource);

  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _authDataSource.signUp(email, password);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! Sign Up has failed',
        methodInFile: 'SingUp()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _authDataSource.signIn(email, password);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! Sign In has failed',
        methodInFile: 'signIn()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      return await _authDataSource.signInWithGoogle();
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! Sign In has failed',
        methodInFile: 'signInWithGoogle()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _authDataSource.signOut();
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! Sign Out has failed',
        methodInFile: 'signOut()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _authDataSource.resetPassword(email);
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! Reset Password has failed',
        methodInFile: 'resetPassword()/AuthRepository',
        details: e.toString(),
      );
    }
  }
}
