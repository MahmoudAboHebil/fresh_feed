import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

final userBookmarksRepoProvider = Provider((ref) {
  final _firestoreDS = ref.watch(firestorDSProvider);
  return UserBookmarksRepository(_firestoreDS);
});
