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

      await userCredential.user?.sendEmailVerification();
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

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
      print('Google Sign In Error: $e');
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

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseService.auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Reset Password Error: $e');
      rethrow;
    }
  }

  User? getCurrentUser() {
    try {
      return _firebaseService.getCurrentUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
