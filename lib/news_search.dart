import 'package:dio/dio.dart';
import 'package:fakenewsdetect/consts.dart';
import 'package:fakenewsdetect/models/article.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsSearch extends StatefulWidget {
  const NewsSearch({super.key});

  @override
  State<NewsSearch> createState() => _NewsSearchState();
}
class _NewsSearchState extends State<NewsSearch> {

  final Dio dio = Dio();
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    _getNews();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NEWS",
        ),
      ),

      body: _buildUI(),
    );
  }

  Widget _buildUI(){
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index){
        final article = articles[index];
        return ListTile(
          onTap: (){
            _launchURL(Uri.parse(article.url ?? ""),);
          },
          leading: Image.network(
            article.urlToImage ?? PLACEHOLDER_IMAGE_URL,
            height: 250,
            width: 100,
            fit: BoxFit.cover,
          ),
          title: Text(article.title ?? ""),
          subtitle: Text(article.publishedAt ?? ""),
        );
      },
    );
  }

  Future<void> _getNews() async{
    final response = await dio.get('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=${NEWS_API_KEY}');

    final articlesJson = response.data['articles'] as List;
    setState(() {
      List<Article> newsArticle = articlesJson.map((article) => Article.fromJson(article)).toList();
      newsArticle = newsArticle.where((a) => a.title != "[Removed]").toList();
      articles =newsArticle;
    });
  }

  Future<void> _launchURL(Uri url) async {
    if(!await launchUrl(url)){
      throw Exception('Could not launch $url');
    }
  }
}
