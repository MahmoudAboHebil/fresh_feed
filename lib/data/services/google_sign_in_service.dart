import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final GoogleSignInService _instance = GoogleSignInService._();
  GoogleSignInService._();
  factory GoogleSignInService() {
    return _instance;
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();
}
