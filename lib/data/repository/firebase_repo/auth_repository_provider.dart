import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/repository/firebase_repo/user_repository_provider.dart';

import '../../datasource/firebase_ds/auth_datasource_provider.dart';
import 'auth_repository.dart';

final authRepositoryProvider = Provider.autoDispose((ref) {
  final authDatasource = ref.read(authDataSourceProvider);
  final userRepo = ref.read(userRepositoryProvider);
  final authRepo = AuthRepository(authDatasource, userRepo);

  ref.onDispose(() {
    print('Desposed 000000000000');
    authRepo.cancelTimer();
  });

  return authRepo;
});
