import 'package:http/http.dart' as http;

Future<String?> fetchOpenGraphImage(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final htmlContent = response.body;
    final ogImageMatch = RegExp(r'<meta property="og:image" content="(.*?)"')
        .firstMatch(htmlContent);
    return ogImageMatch?.group(1); // Extract the image URL
  }
  return null;
}

void main() async {
  final nameRegex = RegExp(
      r"^[A-Za-zÀ-ÖØ-öø-ÿ\u0600-\u06FF\u0400-\u04FF\u4E00-\u9FFF\u3040-\u30FF' -]{2,50}$");
}
