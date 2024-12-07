import 'package:flutter/material.dart';
import '../News Screens/news_service.dart';

class SearchScreen extends StatelessWidget {
  final String query;

  SearchScreen({required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Results')),
      body: FutureBuilder(
        future: NewsService().searchNews(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Center(child: Text('No results found'));
          }

          final articles = snapshot.data as List;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return ListTile(
                title: Text(article['title']),
                subtitle: Text(article['description'] ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}
