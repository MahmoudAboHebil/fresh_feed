import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/datasource/firebase_datasource/firebase_datasource.dart';
import 'package:fresh_feed/data/repository/firebase_repository/user_repository_provider.dart';

import 'auth_repository.dart';

final authRepositoryProvider = Provider((ref) {
  final auth_datasource = ref.watch(authDataSourceProvider);
  final user_repo = ref.watch(userRepositoryProvider);
  return AuthRepository(auth_datasource, user_repo);
});
