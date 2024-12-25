import 'dart:convert';

import 'package:fresh_feed/utils/utlis.dart';
import 'package:http/http.dart' as http;

//fetch data from NewsApi service
class NewsApiDataSource {
  NewsApiDataSource._();
  factory NewsApiDataSource() {
    return _instance;
  }
  static final NewsApiDataSource _instance = NewsApiDataSource._();

  ///todo: you need to hide this key
  final String _apiKey = '0938edb43c304fcdbec275313a280302';
  final String _baseUrl = 'https://newsapi.org/v2';

  // This endpoint provides live top and breaking headlines
  Future<Map<String, dynamic>> fetchTopHeadlines({
    NewsCountry? country = NewsCountry.us,
    NewsLanguage? language = NewsLanguage.en,
    NewsCategory? category,
    String? query,
    int pageSize = 20,
    int page = 1,
    List<String>? sources,
  }) async {
    try {
      final topHeadBaseUrl = '$_baseUrl/top-headlines';
      final Map<String, String> queryParams = {
        'apiKey': _apiKey,
        if (sources == null) 'country': country?.name ?? NewsCountry.us.name,
        'pageSize': pageSize.toString(),
        'page': page.toString(),
        'language': language?.name ?? NewsLanguage.en.name,
      };
      if (category != null) {
        queryParams['category'] = category.name;
      }
      if (query != null && query.isNotEmpty) {
        queryParams['q'] = query;
      }
      if (sources != null && sources.isNotEmpty) {
        final nonEmptyString =
            sources.where((item) => item.isNotEmpty).toSet().toList();
        final sourceForm =
            nonEmptyString.toString().replaceAll(RegExp(r'[\[\]]'), '');
        if (sourceForm.trim().isNotEmpty) {
          queryParams['sources'] = sourceForm;
        }
      }
      final uri =
          Uri.parse(topHeadBaseUrl).replace(queryParameters: queryParams);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception("${response.reasonPhrase}");
      }
    } catch (e) {
      rethrow;
    }
  }

  //This endpoint suits article discovery and analysis.
  Future<Map<String, dynamic>> fetchEverything({
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
      final everythingBaseUrl = '$_baseUrl/everything';
      final Map<String, String> queryParams = {
        'apiKey': _apiKey,
        'q': query, // Mandatory
        'pageSize': pageSize.toString(),
        'page': page.toString(),
        'language': language?.name ?? NewsLanguage.en.name,
        'sortBy': sortBy?.name ?? NewsSortBy.publishedAt.name,
      };

      if (from != null && from.isNotEmpty) {
        queryParams['from'] = from;
      }

      if (to != null && to.isNotEmpty) {
        queryParams['to'] = to;
      }

      if (sources != null && sources.isNotEmpty) {
        final nonEmptyString =
            sources.where((item) => item.isNotEmpty).toSet().toList();
        final sourceForm =
            nonEmptyString.toString().replaceAll(RegExp(r'[\[\]]'), '');
        if (sourceForm.trim().isNotEmpty) {
          queryParams['sources'] = sourceForm;
        }
      }

      if (domains != null && domains.isNotEmpty) {
        final nonEmptyString =
            domains.where((item) => item.isNotEmpty).toSet().toList();
        final domainsForm =
            nonEmptyString.toString().replaceAll(RegExp(r'[\[\]]'), '');
        if (domainsForm.trim().isNotEmpty) {
          queryParams['domains'] = domainsForm;
        }
      }

      if (excludeDomains != null && excludeDomains.isNotEmpty) {
        final nonEmptyString =
            excludeDomains.where((item) => item.isNotEmpty).toSet().toList();
        final excludeDomainsForm =
            nonEmptyString.toString().replaceAll(RegExp(r'[\[\]]'), '');
        if (excludeDomainsForm.trim().isNotEmpty) {
          queryParams['excludeDomains'] = excludeDomainsForm;
        }
      }

      // Build URL
      final uri =
          Uri.parse(everythingBaseUrl).replace(queryParameters: queryParams);

      // HTTP GET Request
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception("${response.reasonPhrase}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchSources({
    NewsCategory? category,
    NewsLanguage? language,
    NewsCountry? country,
  }) async {
    try {
      final sourceBaseUrl = '$_baseUrl/sources';
      final Map<String, String> queryParams = {
        'apiKey': _apiKey,
      };
      if (category != null) {
        queryParams['category'] = category.name;
      }

      if (language != null) {
        queryParams['language'] = language.name;
      }

      if (country != null) {
        queryParams['country'] = country.name;
      }
      final uri =
          Uri.parse(sourceBaseUrl).replace(queryParameters: queryParams);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception("${response.reasonPhrase}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
