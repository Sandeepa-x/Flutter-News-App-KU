import 'dart:convert';
import 'package:http/http.dart' as http;



class NewsService {
  final String _apiKey = '22c8a86847d6427dbe6190dddebb5f92';
  final String _baseUrl = 'https://newsapi.org/v2';

  // news based on the category
  Future<List<dynamic>> fetchNews(String category) async {
    final url = Uri.parse('$_baseUrl/top-headlines?country=us&category=$category&apiKey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to fetch news');
    }
  }

  searchNews(String query) {}
}
