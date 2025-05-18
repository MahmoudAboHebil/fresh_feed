import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/news_models/news_article.dart';
import '../data/repository/news_api_repo/news_api_repo_provider.dart';

class ForYouScreenData {
  const ForYouScreenData({
    required this.durationCartData,
    required this.popularNewsData,
    required this.recommendationData,
  });

  const ForYouScreenData.init()
      : durationCartData = const [],
        popularNewsData = const [],
        recommendationData = const [];

  bool get isNotEmpty =>
      durationCartData.isNotEmpty &&
      recommendationData.isNotEmpty &&
      popularNewsData.isNotEmpty;

  @override
  String toString() {
    return 'ForYouScreenData{durationCartData: $durationCartData, popularNewsData: $popularNewsData, recommendationData: $recommendationData}';
  }

  final List<Article> durationCartData;
  final List<Article> popularNewsData;
  final List<Article> recommendationData;
}

class ForYouScreenDataNotifier extends AsyncNotifier<ForYouScreenData> {
  @override
  Future<ForYouScreenData> build() async {
    return await fetchData();
  }

  Future<ForYouScreenData> fetchData() async {
    try {
      final newsProv = ref.read(newsApiRepoProvider);
      final durationData =
          await newsProv.fetchFullTopHeadlinesArticles(count: 5);

      return ForYouScreenData(
        durationCartData: durationData,
        popularNewsData: [],
        recommendationData: [],
      );
    } catch (e, st) {
      throw AsyncError(e, st);
    }
  }

  void clearData() {
    state = const AsyncValue.data(ForYouScreenData.init());
  }

  Future<void> refreshData() async {
    state = const AsyncValue.loading();
    try {
      final data = await fetchData();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final forYouScreenDataProvider =
    AsyncNotifierProvider<ForYouScreenDataNotifier, ForYouScreenData>(
  () => ForYouScreenDataNotifier(),
);
