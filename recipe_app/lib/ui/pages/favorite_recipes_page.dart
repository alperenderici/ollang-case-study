import 'package:flutter/material.dart';
import 'package:recipe_app/ui/cubit/homepage_cubit.dart';
import 'package:recipe_app/ui/pages/homepage.dart';

class FavoriteRecipesPage extends StatefulWidget {
  const FavoriteRecipesPage({super.key});

  @override
  State<FavoriteRecipesPage> createState() => _FavoriteRecipesPageState();
}

class _FavoriteRecipesPageState extends State<FavoriteRecipesPage> {
  bool isSearch = false;
  bool isFav = false;
  bool isFavSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ? TextField(
                decoration:
                    const InputDecoration(hintText: "Search Favorite Recipe"),
                onChanged: (searchResult) {
                  //TODO SEARCH FAVORITE RECIPES
                },
              )
            : const Text(
                "Favorite Recipes",
              ),
        actions: [
          isSearch
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = false;
                    });
                  },
                  icon: const Icon(Icons.cancel),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = true;
                      //TODO GET RECIPES
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
          IconButton(
            //isFav selected true
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => Homepage()),
                ),
              );
              // .then((value) {
              //   context.read<HomePageCubit>().getRecipes();
              // });
            },
            icon: const Icon(Icons.favorite),
          )
        ],
      ),
    );
  }
}
