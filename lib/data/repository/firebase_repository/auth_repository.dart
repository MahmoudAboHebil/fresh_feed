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
    required String userName,
  }) async {
    User? userFin;
    try {
      final user = await _authDataSource.signUp(email, password);
      if (user == null) {
        throw Exception('user from signUp method equal null');
      }
      userFin = user;
      await _userRepository.updateUser(user, AuthProviderType.email, context,
          username: userName);
      return userFin;
    } on FreshFeedException catch (e) {
      bool isInUserRepo = e.methodInFile?.contains('UserRepository') ?? false;
      if (!isInUserRepo) {
        AppAlerts.displaySnackBar(e.message, context);
        return null;
      }
      return userFin;
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
    User? userFin;
    try {
      final user = await _authDataSource.signIn(email, password);
      if (user == null) {
        throw Exception('user from signIn method equal null');
      }
      userFin = user;
      final storedUserData =
          await _userRepository.getUserData(user.uid, context);
      if (storedUserData == null) {
        // store user info that is failed when sign up
        await _userRepository.updateUser(
            user, AuthProviderType.google, context);
      }
      return userFin;
    } on FreshFeedException catch (e) {
      bool isInUserRepo = e.methodInFile?.contains('UserRepository') ?? false;
      if (!isInUserRepo) {
        AppAlerts.displaySnackBar(e.message, context);
        return null;
      }
      return userFin;
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
    User? userFin;
    try {
      final user = await _authDataSource.signInWithGoogle();
      if (user == null) {
        throw Exception('user from Sign In method equal null');
      }
      userFin = user;
      final storedUserData =
          await _userRepository.getUserData(user.uid, context);
      if (storedUserData == null) {
        // for the first time
        await _userRepository.updateUser(
            user, AuthProviderType.google, context);
      } else if (storedUserData.authProvider != AuthProviderType.google) {
        // when user switching between auth types
        await _userRepository.saveUserData(
            storedUserData.copyWith(authProvider: AuthProviderType.google),
            context);
      }
      return userFin;
    } on FreshFeedException catch (e) {
      bool isInUserRepo = e.methodInFile?.contains('UserRepository') ?? false;
      if (!isInUserRepo) {
        AppAlerts.displaySnackBar(e.message, context);
        return null;
      }
      return userFin;
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
    } on FreshFeedException catch (e) {
      AppAlerts.displaySnackBar(e.message, context);
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
    } on FreshFeedException catch (e) {
      AppAlerts.displaySnackBar(e.message, context);
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
