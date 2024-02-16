import 'package:flutter/material.dart';

class CookbookDetailsPage extends StatelessWidget {
  final int cookbookId;

  CookbookDetailsPage({required this.cookbookId});

  @override
  Widget build(BuildContext context) {
    // Implement the UI to display cookbook details using cookbookId
    // You can retrieve additional data from the API using cookbookId
    return Scaffold(
      appBar: AppBar(
        title: Text('Cookbook Details'),
      ),
      body: Center(
        child: Text('Cookbook ID: $cookbookId'),
      ),
    );
  }
}
