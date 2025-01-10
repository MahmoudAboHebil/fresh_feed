import 'package:equatable/equatable.dart';

import 'news_article.dart';

class ArticleResponse extends Equatable {
  const ArticleResponse({
    this.totalResults = 0,
    required this.articles,
  });
  final int totalResults;
  final List<Article> articles;

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    final articlesList = json['articles'] as List<dynamic>;
    var articlesModels = <Article>[];
    if (articlesList.isNotEmpty) {
      articlesModels =
          articlesList.map((art) => Article.fromJson(art)).toList();
    }

    return ArticleResponse(
      totalResults: json['totalResults'] as int,
      articles: articlesModels,
    );
  }
  ArticleResponse copyWith({
    int? totalResults,
    List<Article>? articles,
  }) {
    return ArticleResponse(
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [totalResults, articles];
}
