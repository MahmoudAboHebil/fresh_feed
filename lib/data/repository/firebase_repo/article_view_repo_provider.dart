import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

final articleViewRepoProvider = Provider((ref) {
  final _firestoreDS = ref.watch(firestorDSProvider);
  return ArticleViewRepository(_firestoreDS);
});
