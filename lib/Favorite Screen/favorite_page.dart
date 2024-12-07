import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../News Screens/news_detail_screen.dart';
import 'FavoriteService.dart';
import 'add_favorite_screen.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteService = Provider.of<FavoriteService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite News"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddFavoriteScreen(), // Add Favorite Screen
                ),
              );
            },
          ),
        ],
      ),
      body: favoriteService.favorites.isEmpty
          ? Center(child: Text("No favorites added yet."))
          : ListView.builder(
        itemCount: favoriteService.favorites.length,
        itemBuilder: (context, index) {
          final article = favoriteService.favorites[index];
          return ListTile(
            leading: article['urlToImage'] != null
                ? Image.network(
              article['urlToImage'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : Icon(Icons.image, size: 50),
            title: Text(
              article['title'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(article['publishedAt'] ?? 'Unknown date'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(article: article),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
