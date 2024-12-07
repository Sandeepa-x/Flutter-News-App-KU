import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'News App\nVersion 1.0\nPowered by NewsAPI.org',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
