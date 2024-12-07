import 'package:flutter/material.dart';

class FavoriteService with ChangeNotifier {

  final List<Map<String, dynamic>> _favorites = [];


  List<Map<String, dynamic>> get favorites => List.unmodifiable(_favorites);

  // Add article
  void addFavorite(Map<String, dynamic> article) {

    if (!_favorites.contains(article)) {
      _favorites.add(article);
      notifyListeners();
    }
  }

  // Remove article
  void removeFavorite(Map<String, dynamic> article) {
    _favorites.remove(article);
    notifyListeners();  // Notify listeners to rebuild UI
  }


  bool isFavorite(Map<String, dynamic> article) {
    return _favorites.contains(article);
  }
}
