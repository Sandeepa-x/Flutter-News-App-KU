import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  NewsDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
              Image.network(article['urlToImage'], fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(
              article['title'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Author: ${article['author'] ?? 'Unknown'}'),
            Text('Published At: ${article['publishedAt'] ?? 'Unknown'}'),
            Divider(),
            Text(article['content'] ?? 'No content available'),
          ],
        ),
      ),
    );
  }
}
