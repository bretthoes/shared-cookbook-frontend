import 'package:flutter/material.dart';

class CookbookDetailsScreen extends StatelessWidget {
  final int cookbookId;

  CookbookDetailsScreen({required this.cookbookId});

  @override
  Widget build(BuildContext context) {
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
