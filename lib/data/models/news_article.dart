import 'package:fresh_feed/data/data.dart';

class Article {
  const Article({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.source,
    this.author,
  });
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt; //2024-12-22T18:25:31Z
  final String? content;

  factory Article.fromJson(Map<String, dynamic> json) {
    var sourceModel;
    if (json['source'] != null) {
      sourceModel = Source.fromJson(json['source']);
    }
    return Article(
      title: json['title'] as String?,
      content: json['content'] as String?,
      url: json['url'] as String?,
      publishedAt: json['publishedAt'] as String?,
      urlToImage: json['urlToImage'] as String?,
      description: json['description'] as String?,
      author: json['author'] as String?,
      source: sourceModel,
    );
  }
}
