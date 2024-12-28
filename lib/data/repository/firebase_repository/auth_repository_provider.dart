import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/datasource/firebase_datasource/firebase_datasource.dart';

import 'auth_repository.dart';

final authRepositoryProvider = Provider((ref) {
  final auth_datasource = ref.watch(authDataSourceProvider);
  return AuthRepository(auth_datasource);
});
