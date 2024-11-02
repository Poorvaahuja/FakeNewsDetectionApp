import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApiService {
  final String weatherApiUrl = 'https://Weather-API.proxy-production.allthingsdev.co/weather/citySearch';
  final Map<String, String> headers = {
    'accept': '/',
    'accept-language': 'en-US,en;q=0.9',
    'origin': 'https://edition.cnn.com',
    'priority': 'u=1, i',
    'referer': 'https://edition.cnn.com/',
    'sec-ch-ua': '"Not/A)Brand";v="8", "Chromium";v="126", "Google Chrome";v="126"',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '"Windows"',
    'sec-fetch-dest': 'empty',
    'sec-fetch-mode': 'cors',
    'sec-fetch-site': 'cross-site',
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36',
    'x-apihub-key': 'o5llesZ3LoUGpQVbyiuW3SBNdzZToexDT2v3o-bGrmH-HcyFcN',
    'x-apihub-host': 'Weather-API.allthingsdev.co',
    'x-apihub-endpoint': '175f72ec-0ec4-4986-bbc6-b098d29b8200'
  };

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final Uri url = Uri.parse('$weatherApiUrl?search_term=${city.isEmpty ? 'Delhi' : city}');
    var response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
