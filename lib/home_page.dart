import 'package:fakenewsdetect/fake_news_page.dart';
import 'package:fakenewsdetect/news_search.dart';
import 'package:fakenewsdetect/weather_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NEWS & SERVICES'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ServiceButton(
              title: 'Detect Fake News',
              icon: Icons.check_circle_outline,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FakeNewsPage())),
            ),
            const SizedBox(height: 10),
            ServiceButton(
              title: 'Weather Updates',
              icon: Icons.wb_sunny,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WeatherPage())),
            ),
            const SizedBox(height: 10),
            ServiceButton(
              title: 'Search News Headlines',
              icon: Icons.search,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewsSearch())),
            ),
          ],
        ),
      ),
    );
  }
}
class ServiceButton extends StatelessWidget{
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ServiceButton({super.key, required this.title, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 24),
      label: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20), backgroundColor: Color.fromARGB(255, 123, 155, 211),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}