import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  FirebaseService._();

  static final FirebaseService _instance = FirebaseService._();

  factory FirebaseService() {
    return _instance;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? getCurrentUser() {
    return auth.currentUser;
  }

  // Listen for auth state changes
  Stream<User?> authStateChanges() {
    return auth.authStateChanges();
  }

  // Listen for token changes
  Stream<User?> idTokenChanges() {
    return auth.idTokenChanges();
  }

  // Listen for user profile updates
  Stream<User?> userChanges() {
    return auth.userChanges();
  }
}
