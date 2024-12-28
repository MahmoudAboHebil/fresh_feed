import 'package:fresh_feed/utils/utlis.dart';

class Source {
  const Source({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.country,
    this.language,
  });
  final String? id;
  final String? name;
  final String? description;
  final String? url;
  final NewsCategory? category;
  final NewsLanguage? language;
  final NewsCountry? country;

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      name: json['name'] as String?,
      country: NewsCountry.stringToNewsLanguage(json['country']),
      url: json['url'] as String?,
      category: NewsCategory.stringToNewsCategory(json['category']),
      description: json['description'] as String?,
      id: json['id'] as String?,
      language: NewsLanguage.stringToNewsLanguage(json['language']),
    );
  }

  @override
  String toString() {
    return '''Source{
    id: $id,
    name: $name,
    description: $description, 
    url: $url, 
    category: $category, 
    language: $language, 
    country: $country}
    ''';
  }
}
