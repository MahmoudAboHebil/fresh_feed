import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/utils/utlis.dart';

class AuthRepository {
  final AuthDataSource _authDataSource;
  final UserRepository _userRepository;
  Timer? _timer;

  AuthRepository(this._authDataSource, this._userRepository);

  // test signUp done
  Future<User?> signUp({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      final user = await _authDataSource.signUp(email, password);
      await _userRepository.updateUser(user!, AuthProviderType.email,
          username: userName);
      return user;
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'email-already-in-use') {
        message = 'This account already exists. Please log in.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format.';
      } else {
        message = 'An error occurred. Please try again.';
      }

      throw FreshFeedException(
          message: message,
          methodInFile: 'signUp()/AuthDataSource',
          details: e.toString());
    } on FreshFeedException catch (e) {
      // Rethrow custom exceptions from UserRepository
      rethrow;
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! An error occurred. Please try again.',
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
        await _userRepository.updateUser(user, AuthProviderType.google);
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
        await _userRepository.updateUser(user, AuthProviderType.google);
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

  Future<bool> isUserEmailVerified() async {
    try {
      return await _authDataSource.isUserEmailVerified();
    } catch (e) {
      throw FreshFeedException(
        message: 'Oops! get email states has failed',
        methodInFile: 'isUserEmailVerified()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      await _authDataSource.sendEmailVerification();
      AppAlerts.displaySnackBar(
          'A verification email has been sent to your email address. Please verify it to continue.',
          context);
    } catch (e) {
      AppAlerts.displaySnackBar(
          'An error occurred. Please try again.', context);

      throw FreshFeedException(
        message: 'An error occurred. Please try again.',
        methodInFile: 'sendEmailVerification()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  void cancelTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  Future<void> listenToEmailVerification(
      UserModel? user, BuildContext context) async {
    if (user != null && !user.emailVerified) {
      try {
        cancelTimer();
        _timer = Timer.periodic(
          const Duration(seconds: 3),
          (timer) async {
            {
              final isEmailUserVerified = await isUserEmailVerified();
              if (isEmailUserVerified) {
                await _userRepository.saveUserData(
                    user.copyWith(emailVerified: true), context);
                AppAlerts.displaySnackBar(
                    'Email verified successfully. Enjoy using our app!',
                    context);
                cancelTimer();
              }
            }
          },
        );
      } catch (e) {
        print('listenToEmailVerification has failed');
      }
    }
  }
}
