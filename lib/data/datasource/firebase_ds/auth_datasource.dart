import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_feed/data/services/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDataSource {
  final GoogleSignIn _googleSignIn;
  final FirebaseService _firebaseService;

  AuthDataSource({
    GoogleSignIn? googleSignIn,
    FirebaseService? firebaseService,
  })  : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firebaseService = firebaseService ?? FirebaseService();

  // signUp test done
  Future<User?> signUp(String email, String password) async {
    try {
      final userCredential =
          await _firebaseService.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // await userCredential.user?.sendEmailVerification();
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> sendOtp(String phoneNumber, Function(String) codeSent) async {
    User? user;
    final Completer<User?> completer = Completer<User?>();

    try {
      await _firebaseService.auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            UserCredential userCredential =
                await _firebaseService.auth.signInWithCredential(credential);
            user = userCredential.user;
            completer.complete(user);
          } on FirebaseAuthException catch (e) {
            completer.completeError(e);
          } catch (e) {
            completer.completeError(FirebaseAuthException(
                code: 'credential-signin-failed',
                message: "Error signing in with credential: $e"));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          codeSent(verificationId);
          completer.complete(null);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("Code auto-retrieval timeout: $verificationId");
        },
      );

      return await completer.future;
    } catch (e) {
      print('========================> sendOtp failed: $e');
      rethrow;
    }
  }

  Future<User?> verifyOtpAndSignIn(
      String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential userCredential =
          await _firebaseService.auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  // test signIn is done
  Future<User?> signIn(String email, String password) async {
    try {
      final userCredential =
          await _firebaseService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  // test sendEmailVerification is done
  Future<void> sendEmailVerification() async {
    try {
      final currentUser = getCurrentUser();
      if (currentUser != null) {
        await currentUser.sendEmailVerification();
      }
    } catch (e) {
      rethrow;
    }
  }

  // testing isUserEmailVerified is done
  Future<bool> isUserEmailVerified() async {
    try {
      await getCurrentUser()?.reload();
      if (getCurrentUser()!.emailVerified) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  // testing signInWithGoogle  is done
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in process
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseService.auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  // test signOut is done
  Future<void> signOut() async {
    try {
      await _firebaseService.auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // testing resetPassword is done
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseService.auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // testing getCurrentUser is done
  User? getCurrentUser() {
    try {
      return _firebaseService.getCurrentUser();
    } catch (e) {
      rethrow;
    }
  }

  // testing deleteUserAccount is done
  Future<void> deleteUserAccount() async {
    try {
      User? user = _firebaseService.getCurrentUser();

      if (user != null) {
        await user.delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
