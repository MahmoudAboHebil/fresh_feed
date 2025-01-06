import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/utils/utlis.dart';

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
  }) async {
    try {
      final user = await _authDataSource.signUp(email, password);
      if (user == null) {
        throw Exception('user from Sign Up method equal null');
      }
      await _userRepository.updateUser(user, AuthProviderType.email,
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
      // Rethrow  exceptions from UserRepository
      await deleteUserAccount();
      rethrow;
    } catch (e) {
      await deleteUserAccount();
      throw FreshFeedException(
        message: 'Oops! An error occurred. Please try again.',
        methodInFile: 'SingUp()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  // test signIn is done
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authDataSource.signIn(email, password);
      if (user == null) {
        throw Exception('user from Sign In method equal null');
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
        message = 'Invalid email or password.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format.';
      } else if (e.code == 'user-disabled') {
        message = 'This account has been disabled.';
      } else {
        message = 'An error occurred. Please try again.';
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
        message: 'Oops! An error occurred. Please try again.',
        methodInFile: 'signIn()/AuthRepository',
        details: e.toString(),
      );
    }
  }

  // testing signInWithGoogle is done
  Future<User> signInWithGoogle() async {
    try {
      final user = await _authDataSource.signInWithGoogle();
      if (user == null) {
        throw Exception('user from Sign In method equal null');
      }
      final storedUserData = await _userRepository.getUserData(user.uid);
      if (storedUserData == null) {
        // for the first time
        await _userRepository.updateUser(user, AuthProviderType.google);
      } else if (storedUserData.authProvider != AuthProviderType.google) {
        // when user switching between auth types
        await _userRepository.saveUserData(
          storedUserData.copyWith(authProvider: AuthProviderType.google),
        );
      }
      return user;
    } on FreshFeedException catch (e) {
      await signOut();
      rethrow;
    } catch (e) {
      await signOut();
      throw FreshFeedException(
        message: 'An error occurred. Please try again.',
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
  Future<void> resetPassword(String email) async {
    try {
      await _authDataSource.resetPassword(email);
    } catch (e) {
      throw FreshFeedException(
        message: "Password reset failed. Please try again later.",
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
        cancelTimer();
        return;
      }
    }
  }
}
