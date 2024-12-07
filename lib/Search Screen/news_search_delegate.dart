import 'package:flutter/material.dart';

class NewsSearchDelegate extends SearchDelegate {
  final String searchQuery;
  final Function(String) onSearch;

  NewsSearchDelegate({required this.searchQuery, required this.onSearch});

  @override
  String? get searchFieldLabel => 'Search for news...';

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Search for "$query"'),
          onTap: () {
            query = searchQuery;
            onSearch(query);
            showResults(context);
          },
        ),
      ],
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    return Center(
      child: Text('Results for "$query"'),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }
}
