import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/data.dart';

final articleCommentRepoProvider = Provider((ref) {
  final _firestoreDS = ref.watch(firestorDSProvider);
  return ArticleCommentRepository(_firestoreDS);
});
