import 'package:equatable/equatable.dart';
import 'package:fresh_feed/data/data.dart';

class Article extends Equatable {
  const Article({
    required this.id,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.source,
    this.author,
  });
  final String id;
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt; //2024-12-22T18:25:31Z
  final String? content;

  factory Article.fromJson(Map<String, dynamic> json) {
    Source? sourceModel;
    if (json['source'] != null) {
      sourceModel = Source.fromJson(json['source']);
    }
    final String sourceName = sourceModel?.name ?? '';
    String title;
    try {
      title = (json['title'] as String?)?.substring(0, 20) ?? '';
    } catch (e) {
      title = (json['title'] as String?) ?? '';
    }
    final String publishAt = (json['publishedAt'] as String?) ?? '';
    final String articleID = "$sourceName-$publishAt-$title";
    return Article(
      id: articleID,
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

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'url': url,
      'publishedAt': publishedAt,
      'urlToImage': urlToImage,
      'description': description,
      'author': author,
      'source': source?.toJson(),
    };
  }

  @override
  String toString() {
    return '''Article{
    'id': $id,
    source: ${source.toString()},
    author: $author,
    title: $title,
    description: $description,
    url: $url, 
    urlToImage: $urlToImage, 
    publishedAt: $publishedAt, 
    content: $content}
    ''';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content
      ];
}
