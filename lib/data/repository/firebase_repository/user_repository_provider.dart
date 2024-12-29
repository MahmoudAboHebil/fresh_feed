import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/data/repository/firebase_repository/user_repository.dart';

final userRepositoryProvider = Provider((ref) {
  final _firestoreDS = ref.watch(firestorDSProvider);
  return UserRepository(_firestoreDS);
});
