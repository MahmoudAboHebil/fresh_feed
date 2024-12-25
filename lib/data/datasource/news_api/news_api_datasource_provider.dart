import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'news_api_datasource.dart';

final newsApiDataSourceProvider = Provider<NewsApiDataSource>((ref) {
  return NewsApiDataSource();
});
