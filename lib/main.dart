import 'package:fresh_feed/data/data.dart';
import 'package:fresh_feed/utils/news_country.dart';
import 'package:fresh_feed/utils/news_language.dart';

void main() async {
  final datasource = NewsDataSource();
  final news = await datasource.fetchSources(
      country: NewsCountry.fr, language: NewsLanguage.en);
  for (var ne in news) {
    print('========================');
    print(ne.toString());
  }

  // runApp(const FreshFeedApp());
}
