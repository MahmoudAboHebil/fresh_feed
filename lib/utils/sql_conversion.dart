import 'package:fresh_feed/data/data.dart';

class SqlConversion {
  const SqlConversion._();

  static Map<String, dynamic> convertSourceToSql(
      {Source? source, required Article article}) {
    return {
      'sourceId': source?.id,
      'artTitle': article.title,
      'name': source?.name,
      'description': source?.description,
      'url': source?.url,
      'category': source?.category?.name,
      'language': source?.language?.name,
      'country': source?.country?.name
    };
  }

  static Map<String, dynamic> convertArticleToSql({
    Article? article,
    int? sourceFK,
  }) {
    return {
      'title': article?.title,
      'description': article?.description,
      'url': article?.url,
      'urlToImage': article?.urlToImage,
      'publishedAt': article?.publishedAt,
      'content': article?.content,
      if (sourceFK != null) 'source_fk': sourceFK,
      'author': article?.author,
    };
  }

  static Map<String, dynamic> convertSqlMapToArticleMap(
      Map<String, dynamic> data) {
    return {
      'source': {
        'id': data['sourceId'],
        'name': data['name'],
        'description': data['source_description'],
        'url': data['source_url'],
        'category': data['category'],
        'language': data['language'],
        'country': data['country']
      },
      'author': data['author'],
      'title': data['title'],
      'description': data['description'],
      'url': data['url'],
      'urlToImage': data['urlToImage'],
      'publishedAt': data['publishedAt'],
      'content': data['content']
    };
  }
}
