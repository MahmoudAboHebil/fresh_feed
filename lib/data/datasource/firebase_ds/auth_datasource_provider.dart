import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

final authDataSourceProvider = Provider((ref) {
  final authService = FirebaseService();
  final googleService = GoogleSignInService();
  return AuthDataSource(
      googleSignIn: googleService.googleSignIn, firebaseService: authService);
});
