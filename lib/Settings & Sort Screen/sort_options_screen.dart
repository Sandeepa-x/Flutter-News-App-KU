import 'package:flutter/material.dart';

class SortOptionsScreen extends StatelessWidget {
  final Function(String) onSortSelected;

  SortOptionsScreen({required this.onSortSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sort Options'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Sort by Date (Newest to Oldest)'),
            onTap: () {
              onSortSelected('date');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Sort by Title (A-Z)'),
            onTap: () {
              onSortSelected('title');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
