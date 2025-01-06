import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/repository/firebase_repo/user_repository.dart';

import '../../datasource/firebase_ds/firestor_ds_provider.dart';

final userRepositoryProvider = Provider((ref) {
  final _firestoreDS = ref.read(firestorDSProvider);

  return UserRepository(_firestoreDS);
});
