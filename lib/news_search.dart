import 'package:flutter/material.dart';
import 'news_api_service.dart';

class NewsSearch extends StatefulWidget {
  @override
  _NewsSearchState createState() => _NewsSearchState();
}

class _NewsSearchState extends State<NewsSearch> {
  final TextEditingController _controller = TextEditingController();
  final NewsApiService apiService = NewsApiService();
  List<dynamic> newsArticles = [];
  bool isLoading = false;

  Future<void> searchNews(String query) async {
    setState(() {
      isLoading = true;
    });
    try {
      final articles = await apiService.fetchNews(query);
      setState(() {
        newsArticles = articles;
      });
    } catch (e) {
      // Handle error (e.g., show a snackbar or dialog)
      print("Error fetching news: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search News Headlines")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter a keyword",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (query) {
                searchNews(query);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                searchNews(_controller.text);
              },
              child: const Text("Search"),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: newsArticles.length,
                      itemBuilder: (context, index) {
                        final article = newsArticles[index];
                        return ListTile(
                          title: Text(article['title'] ?? 'No Title'),
                          subtitle: Text(article['description'] ?? 'No Description'),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
