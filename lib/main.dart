import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Favorite Screen/FavoriteService.dart';
import 'Home Screen/home_screen.dart';
import 'Settings & Sort Screen/settings_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteService()), //FavoriteService
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: HomeScreen(),
      routes: {
        '/settings': (context) => SettingsScreen(), // screen registration
      },
    );
  }
}
