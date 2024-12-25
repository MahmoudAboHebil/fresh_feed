import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/datasource/datasource.dart';

import 'news_api_repo.dart';

final newsApiRepoProvider = Provider<NewsApiRepository>((ref) {
  final datasource = ref.watch(newsApiDataSourceProvider);
  return NewsApiRepository(datasource);
});
