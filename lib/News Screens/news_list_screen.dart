import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Favorite Screen/FavoriteService.dart';
import '../Search Screen/news_search_delegate.dart';
import 'news_service.dart';
import 'news_detail_screen.dart';
import '../Settings & Sort Screen/sort_options_screen.dart';

class NewsListScreen extends StatefulWidget {
  final String category;

  NewsListScreen({required this.category});

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final NewsService _newsService = NewsService();
  List<dynamic> _articles = [];
  List<dynamic> _filteredArticles = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  // news based on the selected category
  void _fetchNews() async {
    final articles = await _newsService.fetchNews(widget.category);
    setState(() {
      _articles = articles;
      _filteredArticles = articles;
      _isLoading = false;
    });
  }

  void _searchArticles(String query) {
    setState(() {
      _searchQuery = query;
      _filteredArticles = _articles.where((article) {
        final title = article['title'].toLowerCase();
        return title.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _sortArticles(String criteria) {
    setState(() {
      if (criteria == 'date') {
        _filteredArticles.sort((a, b) => b['publishedAt'].compareTo(a['publishedAt']));
      } else if (criteria == 'title') {
        _filteredArticles.sort((a, b) => a['title'].compareTo(b['title']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteService = Provider.of<FavoriteService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category.toUpperCase()} News'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NewsSearchDelegate(
                  searchQuery: _searchQuery,
                  onSearch: _searchArticles,
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              // Navigate to Sort Options Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SortOptionsScreen(
                    onSortSelected: (criteria) {
                      _sortArticles(criteria); // Apply sorting
                    },
                  ),
                ),
              );
            },
          ),
          
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _searchArticles,
              decoration: InputDecoration(
                hintText: 'Search for news...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: _filteredArticles.length,
              itemBuilder: (context, index) {
                final article = _filteredArticles[index];
                final isFavorite = favoriteService.isFavorite(article);

                return Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(article: article),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: article['urlToImage'] != null
                              ? Image.network(
                            article['urlToImage'],
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                              : Container(
                            height: 120,
                            color: Colors.grey[300],
                            child: Icon(Icons.image, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            article['title'] ?? 'No Title Available',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'By: ${article['author'] ?? 'Unknown'}',
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Published on: ${article['publishedAt'] ?? 'Unknown'}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            if (isFavorite) {
                              favoriteService.removeFavorite(article);
                            } else {
                              favoriteService.addFavorite(article);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}

