class NewsApiPaginationState<Article> {
  final List<Article> items;
  final bool isLoading;
  final bool hasMore;

  NewsApiPaginationState({
    this.items = const [],
    this.isLoading = false,
    this.hasMore = true,
  });

  NewsApiPaginationState<Article> copyWith({
    List<Article>? items,
    bool? isLoading,
    bool? hasMore,
  }) {
    return NewsApiPaginationState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
