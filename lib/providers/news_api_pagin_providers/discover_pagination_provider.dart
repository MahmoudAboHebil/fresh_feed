import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/data/models/news_models/news_article.dart';
import 'package:fresh_feed/providers/news_api_pagin_providers/news_api_pagin_providers.dart';

import '../../data/repository/news_api_repo/news_api_repo_provider.dart';
import '../../utils/languages.dart';
import '../../utils/news_sort_by.dart';

class DiscoverPaginationNotifier
    extends Notifier<NewsApiPaginationState<Article>> {
  @override
  NewsApiPaginationState<Article> build() {
    return NewsApiPaginationState<Article>();
  }

  Future<void> fetchEverything({
    String? from,
    String? to,
    Language? language = Language.en,
    NewsSortBy? sortBy = NewsSortBy.publishedAt,
    int pageSize = 10,
    List<String>? sources,
    List<String>? domains,
    List<String>? excludeDomains,
  }) async {
    final newsRepo = ref.read(newsApiRepoProvider);
    final currentState = state;
    if (currentState.isLoading || !currentState.hasMore) return;

    state = currentState.copyWith(isLoading: true);

    try {
      final response = await newsRepo.fetchEverything(
        page: (currentState.items.length ~/ pageSize) + 1,
        pageSize: pageSize,
        sources: sources,
        language: language,
        to: to,
        from: from,
        excludeDomains: excludeDomains,
        sortBy: sortBy,
        domains: domains,
      );

      final List<Article> fetchedNews = response.articles;

      state = currentState.copyWith(
        items: [...currentState.items, ...fetchedNews],
        isLoading: false,
        hasMore: fetchedNews.length == pageSize,
      );
    } catch (e) {
      state = currentState.copyWith(isLoading: false);
      rethrow;
    }
  }
}

final discoverPaginProvider = NotifierProvider<DiscoverPaginationNotifier,
    NewsApiPaginationState<Article>>(() {
  return DiscoverPaginationNotifier();
});
