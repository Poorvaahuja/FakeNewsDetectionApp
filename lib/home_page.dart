import 'package:fakenewsdetect/fake_news_page.dart';
import 'package:fakenewsdetect/news_search.dart';
import 'package:fakenewsdetect/weather_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS & SERVICES'),
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
            SizedBox(height: 10),
            ServiceButton(
              title: 'Weather Updates',
              icon: Icons.wb_sunny,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherPage())),
            ),
            SizedBox(height: 10),
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

  const ServiceButton({required this.title, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 24),
      label: Text(title),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20), backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}