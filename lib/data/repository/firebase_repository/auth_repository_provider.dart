import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/datasource/firebase_datasource/firebase_datasource.dart';
import 'package:fresh_feed/data/repository/firebase_repository/user_repository_provider.dart';

import 'auth_repository.dart';

final authRepositoryProvider = Provider.autoDispose((ref) {
  final authDatasource = ref.read(authDataSourceProvider);
  final userRepo = ref.read(userRepositoryProvider);
  final authRepo = AuthRepository(authDatasource, userRepo);

  ref.onDispose(() {
    authRepo.cancelTimer();
  });

  return authRepo;
});
