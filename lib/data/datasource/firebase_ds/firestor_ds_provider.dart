import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

final firestorDSProvider = Provider((ref) {
  final _firebaseService = FirebaseService();
  return FirestoreDatasource(_firebaseService);
});
