import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsApiService {
  final String apiUrl = 'https://World-News-API.proxy-production.allthingsdev.co/search-news';
  final Map<String, String> headers = {
    'Accept': 'application/json',
    'x-apihub-key': 'o5llesZ3LoUGpQVbyiuW3SBNdzZToexDT2v3o-bGrmH-HcyFcN',
    'x-apihub-host': 'World-News-API.allthingsdev.co',
    'x-apihub-endpoint': 'b3165457-cc74-4cbb-b056-ff6aa2932955'
  };

  Future<List<dynamic>> fetchNews(String query) async {
    var url = Uri.parse(
      '$apiUrl?text=$query&source-countries=US&language=en&min-sentiment=-0.8&max-sentiment=0.99&'
      'earliest-publish-date=2022-04-22+16:12:35&latest-publish-date=2022-04-22+16:12:35&'
      'news-sources=https://www.bbc.co.uk&authors=John+Doe&entities=ORG:Tesla&location-filter=51.050407,+13.737262,+20&'
      'sort=publish-time&sort-direction=ASC&offset=0&number=10'
    );

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Decode JSON response into a List of articles
      var data = jsonDecode(response.body);
      return data['articles'] ?? []; // Assuming 'articles' is the key in the JSON response
    } else {
      throw Exception('Failed to load news');
    }
  }
}
