import 'package:fresh_feed/data/datasource/datasource.dart';
import 'package:fresh_feed/utils/utlis.dart';

import '../../models/models.dart';

// handling data from news api datasource
class NewsApiRepository {
  final NewsApiDataSource _dataSource;
  const NewsApiRepository(this._dataSource);

  Future<ArticleResponse> fetchTopHeadlines({
    NewsCountry? country = NewsCountry.us,
    NewsLanguage? language = NewsLanguage.en,
    NewsCategory? category,
    String? query,
    int pageSize = 20,
    int page = 1,
    List<String>? sources,
  }) async {
    try {
      final articleResponse = await _dataSource.fetchTopHeadlines(
        language: language,
        category: category,
        country: country,
        query: query,
        sources: sources,
        pageSize: pageSize,
        page: page,
      );
      return ArticleResponse.fromJson(articleResponse);
    } catch (e) {
      throw const FreshFeedException(
          message: 'Oops! Something went wrong. Please try again later');
    }
  }

  Future<ArticleResponse> fetchEverything({
    required String query,
    String? from,
    String? to,
    NewsLanguage? language = NewsLanguage.en,
    NewsSortBy? sortBy = NewsSortBy.publishedAt,
    int pageSize = 20,
    int page = 1,
    List<String>? sources,
    List<String>? domains,
    List<String>? excludeDomains,
  }) async {
    try {
      final articleResponse = await _dataSource.fetchEverything(
        language: language,
        domains: domains,
        from: from,
        query: query,
        sources: sources,
        pageSize: pageSize,
        page: page,
        sortBy: sortBy,
        excludeDomains: excludeDomains,
        to: to,
      );
      return ArticleResponse.fromJson(articleResponse);
    } catch (e) {
      throw const FreshFeedException(
          message: 'Oops! Something went wrong. Please try again later');
    }
  }

  Future<List<Source>> fetchSources({
    NewsCategory? category,
    NewsLanguage? language,
    NewsCountry? country,
  }) async {
    try {
      final sourceResponse = await _dataSource.fetchSources(
        language: language,
        category: category,
        country: country,
      );
      return (sourceResponse['sources'] as List)
          .map((item) => Source.fromJson(item))
          .toList();
    } catch (e) {
      throw const FreshFeedException(
          message: 'Oops! Something went wrong. Please try again later');
    }
  }
}