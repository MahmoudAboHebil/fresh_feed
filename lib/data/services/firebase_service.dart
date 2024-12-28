import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  // Singleton pattern
  FirebaseService._privateConstructor();

  static final FirebaseService _instance =
      FirebaseService._privateConstructor();

  factory FirebaseService() {
    return _instance;
  }

  // Firebase Instances
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
}
