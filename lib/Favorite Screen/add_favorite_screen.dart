import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'FavoriteService.dart';

class AddFavoriteScreen extends StatefulWidget {
  @override
  _AddFavoriteScreenState createState() => _AddFavoriteScreenState();
}

class _AddFavoriteScreenState extends State<AddFavoriteScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _author = '';
  String _publishedAt = '';
  String _urlToImage = '';

  @override
  Widget build(BuildContext context) {
    final favoriteService = Provider.of<FavoriteService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Favorite News"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                validator: (value) => value!.isEmpty ? "Title is required" : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Author"),
                onSaved: (value) => _author = value ?? "Unknown",
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Published Date"),
                onSaved: (value) => _publishedAt = value ?? "Unknown",
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Image URL"),
                onSaved: (value) => _urlToImage = value ?? "",
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Add to Favorites"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newArticle = {
                      'title': _title,
                      'author': _author,
                      'publishedAt': _publishedAt,
                      'urlToImage': _urlToImage,
                    };
                    favoriteService.addFavorite(newArticle);
                    Navigator.pop(context); // Return to the favorites page
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
