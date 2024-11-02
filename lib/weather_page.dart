import 'package:fakenewsdetect/weather_api_service.dart';
import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherApiService apiService = WeatherApiService();
  final TextEditingController _cityController = TextEditingController(text: 'Delhi');
  Map<String, dynamic> weatherData = {};
  bool isLoading = false;

  Future<void> fetchWeatherData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await apiService.fetchWeather(_cityController.text);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      print("Error fetching weather: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load weather data')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WEATHER UPDATES")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: "Enter city name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchWeatherData,
              child: Text("Get Weather"),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : weatherData.isNotEmpty
                    ? Column(
                        children: [
                          Text("City: ${weatherData['city_name'] ?? 'N/A'}", style: TextStyle(fontSize: 22)),
                          Text("Temperature: ${weatherData['temp'] ?? 'N/A'}°C", style: TextStyle(fontSize: 18)),
                          Text("Description: ${weatherData['weather_description'] ?? 'N/A'}", style: TextStyle(fontSize: 18)),
                        ],
                      )
                    : Text("Enter a city name to get weather updates"),
          ],
        ),
      ),
    );
  }
}