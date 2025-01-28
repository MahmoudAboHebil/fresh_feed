import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/models/news_models/news_article.dart';
import 'package:fresh_feed/providers/news_api_pagin_providers/news_api_pagin_providers.dart';

import '../../data/repository/news_api_repo/news_api_repo_provider.dart';
import '../../utils/news_category.dart';
import '../../utils/news_country.dart';
import '../../utils/news_language.dart';

class TopHeadingPaginationNotifier
    extends Notifier<Map<String, NewsApiPaginationState<Article>>> {
  @override
  Map<String, NewsApiPaginationState<Article>> build() {
    return {};
  }

  Future<void> fetchTopHeadlines({
    NewsCountry? country = NewsCountry.us,
    NewsLanguage? language = NewsLanguage.en,
    NewsCategory? category,
    int pageSize = 10,
    List<String>? sources,
  }) async {
    final newsRepo = ref.read(newsApiRepoProvider);
    String cate = category?.name ?? 'mix';
    final currentState = state[cate] ?? NewsApiPaginationState<Article>();
    if (currentState.isLoading || !currentState.hasMore) return;

    state = {
      ...state,
      cate: currentState.copyWith(isLoading: true),
    };

    try {
      final response = await newsRepo.fetchTopHeadlines(
          page: (currentState.items.length ~/ pageSize) + 1,
          pageSize: pageSize,
          sources: sources,
          country: country,
          category: category,
          language: language);

      final List<Article> fetchedNews = response.articles;

      state = {
        ...state,
        cate: currentState.copyWith(
          items: [...currentState.items, ...fetchedNews],
          isLoading: false,
          hasMore: fetchedNews.length == pageSize,
        ),
      };
    } catch (e) {
      state = {
        ...state,
        cate: currentState.copyWith(isLoading: false),
      };
      rethrow;
    }
  }
}

final topHeadlinesPaginProvider = NotifierProvider<TopHeadingPaginationNotifier,
    Map<String, NewsApiPaginationState<Article>>>(() {
  return TopHeadingPaginationNotifier();
});
