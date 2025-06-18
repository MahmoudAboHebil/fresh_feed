import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_feed/providers/user_followed_channels_provider.dart';
import 'package:fresh_feed/providers/user_provider.dart';

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
    return await _fetchData();
  }

  Future<List<Article>?> _getRecommendationData() async {
    try {
      final newsProv = ref.read(newsApiRepoProvider);
      final user = await ref.read(authStateNotifierProvider.future);
      final userFollowedProv =
          ref.read(userFollowedChannelsNotifierProvider.notifier);
      final List<String>? listOfSources =
          await userFollowedProv.loadDataIfStateIsNull(user?.uid);
      if (listOfSources == null) return null;
      final data = await newsProv.fetchFullTopHeadlinesArticles(
          count: 5, sources: listOfSources, countWidth: 10);
      return data;
    } catch (e, st) {
      throw AsyncError(e, st);
    }
  }

  Future<ForYouScreenData> _fetchData() async {
    try {
      List<Article> data;
      var recommendationData = await _getRecommendationData();

      final newsProv = ref.read(newsApiRepoProvider);
      if (recommendationData != null) {
        data = await newsProv.fetchFullTopHeadlinesArticles(
            count: 10, countWidth: 20);
      } else {
        data = await newsProv.fetchFullTopHeadlinesArticles(
            count: 15, countWidth: 30);
        recommendationData = data.length > 10 ? data.sublist(10) : [];
      }
      final List<Article> durationCartData =
          data.length >= 5 ? data.sublist(0, 5) : [];
      final List<Article> popularNewsData =
          data.length > 5 ? data.sublist(5, data.length.clamp(5, 10)) : [];

      return ForYouScreenData(
        durationCartData: durationCartData,
        popularNewsData: popularNewsData,
        recommendationData: recommendationData,
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
      final data = await _fetchData();
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
