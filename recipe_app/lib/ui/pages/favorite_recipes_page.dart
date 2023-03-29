import 'package:flutter/material.dart';

class FavoriteRecipesPage extends StatefulWidget {
  const FavoriteRecipesPage({super.key});

  @override
  State<FavoriteRecipesPage> createState() => _FavoriteRecipesPageState();
}

class _FavoriteRecipesPageState extends State<FavoriteRecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes Page'),
      ),
    );
  }
}
