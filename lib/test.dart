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
  final x = await fetchOpenGraphImage("http://www.ew.com");
  print(x);
}
