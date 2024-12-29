import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/utils/utlis.dart';

class AuthRepository {
  final AuthDataSource _authDataSource;
  final UserRepository _userRepository;

  const AuthRepository(this._authDataSource, this._userRepository);

  Future<User?> signUp({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authDataSource.signUp(email, password);
      if (user == null) {
        throw Exception('user from signUp method equal null');
      }
      await _userRepository.updateUser(user, AuthProviderType.email);
      return user;
    } on FreshFeedException catch (e) {
      AppAlerts.displaySnackBar(e.message, context);
      return null;
    } catch (e) {
      AppAlerts.displaySnackBar('Oops! Sign Up has failed', context);
      throw FreshFeedException(
        message: 'Oops! Sign Up has failed',
        methodInFile: 'SingUp()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  Future<User?> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authDataSource.signIn(email, password);
      if (user == null) {
        throw Exception('user from signIn method equal null');
      }
      await _userRepository.updateUser(user, AuthProviderType.email);

      return user;
    } on FreshFeedException catch (e) {
      AppAlerts.displaySnackBar(e.message, context);
      return null;
    } catch (e) {
      AppAlerts.displaySnackBar('Oops! Sign In has failed', context);
      throw FreshFeedException(
        message: 'Oops! Sign In has failed',
        methodInFile: 'signIn()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final user = await _authDataSource.signInWithGoogle();
      if (user == null) {
        throw Exception('user from Sign In method equal null');
      }
      await _userRepository.updateUser(user, AuthProviderType.google);

      return user;
    } catch (e) {
      AppAlerts.displaySnackBar('Oops! Sign In has failed', context);

      throw FreshFeedException(
        message: 'Oops! Sign In has failed',
        methodInFile: 'signInWithGoogle()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _authDataSource.signOut();
    } catch (e) {
      AppAlerts.displaySnackBar('Oops! Sign Out has failed', context);
      throw FreshFeedException(
        message: 'Oops! Sign Out has failed',
        methodInFile: 'signOut()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await _authDataSource.resetPassword(email);
    } catch (e) {
      AppAlerts.displaySnackBar('Oops! Reset Password has failed', context);

      throw FreshFeedException(
        message: 'Oops! Reset Password has failed',
        methodInFile: 'resetPassword()/AuthRepository',
        details: e.toString(),
      );
    }
  }
}
