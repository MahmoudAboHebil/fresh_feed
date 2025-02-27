import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/utils/utlis.dart';

import '../../../generated/l10n.dart';

class AuthRepository {
  final AuthDataSource _authDataSource;
  final UserRepository _userRepository;
  Timer? _timer;

  AuthRepository(this._authDataSource, this._userRepository);

  // test signUp done
  Future<User> signUp({
    required String email,
    required String password,
    required String userName,
    required BuildContext context,
  }) async {
    try {
      final user = await _authDataSource.signUp(email, password);
      if (user == null) {
        throw Exception(S.of(context).nullUserExp);
      }
      await _userRepository.updateUser(user, AuthProviderType.email,
          username: userName);
      return user;
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'email-already-in-use') {
        message = S.of(context).accountAlreadyExistsExp;
      } else if (e.code == 'invalid-email') {
        message = S.of(context).invalidEmailFormatExp;
      } else {
        message = S.of(context).errorExp;
      }
      throw FreshFeedException(
          message: message,
          methodInFile: 'signUp()/AuthDataSource',
          details: e.toString());
    } on FreshFeedException catch (e) {
      // Rethrow  exceptions from UserRepository
      await deleteUserAccount();
      rethrow;
    } catch (e) {
      await deleteUserAccount();
      throw FreshFeedException(
        message: S.of(context).errorExp,
        methodInFile: 'SingUp()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  // test signIn is done
  Future<User> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final user = await _authDataSource.signIn(email, password);
      if (user == null) {
        throw Exception(S.of(context).nullUserExp);
      }
      final storedUserData = await _userRepository.getUserData(user.uid);
      if (storedUserData == null) {
        // for the first time
        await _userRepository.updateUser(user, AuthProviderType.email);
      } else if (storedUserData.authProvider != AuthProviderType.email) {
        // when user switching between auth types
        await _userRepository.saveUserData(
          storedUserData.copyWith(authProvider: AuthProviderType.email),
        );
      }
      return user;
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'invalid-credential') {
        message = S.of(context).invalidCredentialExp;
      } else if (e.code == 'invalid-email') {
        message = S.of(context).invalidEmailFormatExp;
      } else if (e.code == 'user-disabled') {
        message = S.of(context).userDisabledExp;
      } else {
        message = S.of(context).errorExp;
      }
      throw FreshFeedException(
        message: message,
        methodInFile: 'signIn()/AuthDataSource',
        details: e.toString(),
      );
    } on FreshFeedException catch (e) {
      // Rethrow  exceptions from UserRepository
      await signOut();
      rethrow;
    } catch (e) {
      await signOut();
      throw FreshFeedException(
        message: S.of(context).errorExp,
        methodInFile: 'signIn()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  Future<User?> sendOtp(String phoneNumber, Function(String) codeSent) async {
    try {
      final user = await _authDataSource.sendOtp(phoneNumber, codeSent);
      if (user != null) {
        final storedUserData = await _userRepository.getUserData(user.uid);
        if (storedUserData == null) {
          // for the first time
          await _userRepository.updateUser(user, AuthProviderType.phone);
        } else if (storedUserData.authProvider != AuthProviderType.phone) {
          // when user switching between auth types
          await _userRepository.saveUserData(
            storedUserData.copyWith(authProvider: AuthProviderType.phone),
          );
        }
      }
      return user;
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'invalid-phone-number') {
        message = 'The provided phone number is not valid.';
      } else if (e.code == 'quota-exceeded') {
        message = 'Quota exceeded. Try again later.';
      } else if (e.code == 'network-request-failed') {
        message = 'Network error. Check your connection.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many attempts. Try again later.';
      } else if (e.code == 'invalid-verification-code') {
        message = 'Invalid verification code. Please try again.';
      } else if (e.code == 'invalid-verification-id') {
        message = 'Invalid verification ID. Please request a new code.';
      } else if (e.code == 'session-expired') {
        message = 'Session expired. Please request a new OTP.';
      } else {
        message = 'An error occurred. Please try again.';
      }

      throw FreshFeedException(
        message: message,
        methodInFile: 'sendOtp()/AuthRepository',
        details: e.toString(),
      );
    } on FreshFeedException catch (e) {
      await signOut();
      rethrow;
    } catch (e) {
      await signOut();
      throw FreshFeedException(
        message: 'Oops! An error occurred. Please try again.',
        methodInFile: 'sendOtp()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  Future<User?> verifyOtpAndSignIn(
      String verificationId, String smsCode) async {
    try {
      final user =
          await _authDataSource.verifyOtpAndSignIn(verificationId, smsCode);
      if (user != null) {
        final storedUserData = await _userRepository.getUserData(user.uid);
        if (storedUserData == null) {
          // for the first time
          await _userRepository.updateUser(user, AuthProviderType.phone);
        } else if (storedUserData.authProvider != AuthProviderType.phone) {
          // when user switching between auth types
          await _userRepository.saveUserData(
            storedUserData.copyWith(authProvider: AuthProviderType.phone),
          );
        }
      }
      return user;
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'invalid-phone-number') {
        message = 'The provided phone number is not valid.';
      } else if (e.code == 'quota-exceeded') {
        message = 'Quota exceeded. Try again later.';
      } else if (e.code == 'network-request-failed') {
        message = 'Network error. Check your connection.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many attempts. Try again later.';
      } else if (e.code == 'invalid-verification-code') {
        message = 'Invalid verification code. Please try again.';
      } else if (e.code == 'invalid-verification-id') {
        message = 'Invalid verification ID. Please request a new code.';
      } else if (e.code == 'session-expired') {
        message = 'Session expired. Please request a new OTP.';
      } else {
        message = 'An error occurred. Please try again.';
      }

      throw FreshFeedException(
        message: message,
        methodInFile: 'verifyOtpAndSignIn()/AuthRepository',
        details: e.toString(),
      );
    } on FreshFeedException catch (e) {
      await signOut();
      rethrow;
    } catch (e) {
      await signOut();
      throw FreshFeedException(
        message: 'Oops! An error occurred. Please try again.',
        methodInFile: 'verifyOtpAndSignIn()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  // testing signInWithGoogle is done
  Future<User> signInWithGoogle(BuildContext context) async {
    try {
      final user = await _authDataSource.signInWithGoogle();
      if (user == null) {
        throw Exception(S.of(context).nullUserExp);
      }
      final storedUserData = await _userRepository.getUserData(user.uid);
      if (storedUserData == null) {
        // for the first time
        await _userRepository.updateUser(user, AuthProviderType.google);
      } else if (storedUserData.authProvider != AuthProviderType.google) {
        // when user switching between auth types
        await _userRepository.saveUserData(
          storedUserData.copyWith(
            authProvider: AuthProviderType.google,
            emailVerified: user.emailVerified,
            profileImageUrl: storedUserData.profileImageUrl ?? user.photoURL,
            name: storedUserData.name.isEmpty ? user.displayName : null,
          ),
        );
      }
      return user;
    } on FreshFeedException catch (e) {
      await signOut();
      rethrow;
    } catch (e) {
      await signOut();
      throw FreshFeedException(
        message: S.of(context).errorExp,
        methodInFile: 'signInWithGoogle()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  // test signOut is done
  Future<void> signOut() async {
    try {
      await _authDataSource.signOut();
    } catch (e) {
      throw FreshFeedException(
        message: 'An error occurred. Please try again.',
        methodInFile: 'signOut()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  // testing deleteUserAccount is done
  Future<void> deleteUserAccount() async {
    try {
      await _authDataSource.deleteUserAccount();
    } catch (e) {
      throw FreshFeedException(
        message: "User deletion failed. Please try again later.",
        methodInFile: 'deleteUserAccount()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  // test resetPassword is done
  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await _authDataSource.resetPassword(email);
    } catch (e) {
      throw FreshFeedException(
        message: S.of(context).resetPasswordExp,
        methodInFile: 'resetPassword()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  // testing isUserEmailVerified is done
  Future<bool> isUserEmailVerified() async {
    try {
      return await _authDataSource.isUserEmailVerified();
    } catch (e) {
      throw FreshFeedException(
        message: "Failed to retrieve email status. Please try again.",
        methodInFile: 'isUserEmailVerified()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  // testing sendEmailVerification is done
  Future<void> sendEmailVerification() async {
    try {
      await _authDataSource.sendEmailVerification();
    } catch (e) {
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

  // testing listenToEmailVerification is done
  Future<void> listenToEmailVerification(
      UserModel? user, VoidCallback successUpdateAlert) async {
    if (user != null && !user.emailVerified) {
      try {
        cancelTimer();
        _timer = Timer.periodic(
          const Duration(seconds: 3),
          (timer) async {
            print('xxxxxxxxxxxxxxxxxxxxx');
            final isEmailUserVerified = await isUserEmailVerified();
            if (isEmailUserVerified) {
              await _userRepository
                  .saveUserData(user.copyWith(emailVerified: true));
              successUpdateAlert();
              cancelTimer();
            }
          },
        );
      } catch (e) {
        print('yyyyyyyyyyyyyyyyyyy$e');

        cancelTimer();
        return;
      }
    }
  }
}
