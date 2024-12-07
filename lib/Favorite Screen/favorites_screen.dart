import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'FavoriteService.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteService = Provider.of<FavoriteService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favoriteService.favorites.isEmpty
          ? Center(child: Text('No favorites yet!'))
          : ListView.builder(
        itemCount: favoriteService.favorites.length,
        itemBuilder: (context, index) {
          final article = favoriteService.favorites[index];
          return ListTile(
            leading: article['urlToImage'] != null
                ? Image.network(article['urlToImage'], width: 100, fit: BoxFit.cover)
                : null,
            title: Text(article['title']),
            subtitle: Text(article['description'] ?? ''),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                favoriteService.removeFavorite(article);
              },
            ),
          );
        },
      ),
    );
  }
}
