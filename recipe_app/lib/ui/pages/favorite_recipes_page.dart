import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/data/repo/recipe_repository.dart';
import 'package:recipe_app/ui/cubit/favorite_recipes_cubit.dart';
import 'package:recipe_app/ui/cubit/favorite_recipes_state.dart';
import 'package:recipe_app/ui/cubit/homepage_cubit.dart';
import 'package:recipe_app/ui/pages/homepage.dart';
import 'package:recipe_app/ui/pages/recipe_detail_page.dart';

class FavoriteRecipesPage extends StatefulWidget {
  final RecipeRepository recipeRepository;
  const FavoriteRecipesPage({Key? key, required this.recipeRepository})
      : super(key: key);

  @override
  State<FavoriteRecipesPage> createState() => _FavoriteRecipesPageState();
}

class _FavoriteRecipesPageState extends State<FavoriteRecipesPage> {
  bool isSearch = false;
  bool isFav = false;
  bool isFavSelected = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<FavoriteRecipesCubit>();
      cubit.loadFavoriteRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ? TextField(
                decoration:
                    const InputDecoration(hintText: "Search Favorite Recipe"),
                onChanged: (searchResult) {
                  context
                      .read<FavoriteRecipesCubit>()
                      .searchFavoriteRecipes(searchResult);
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
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => const Homepage()),
                ),
              ).then((value) {
                context.read<HomePageCubit>().getRecipes();
              });
            },
            icon: const Icon(Icons.favorite),
          )
        ],
      ),
      body: BlocBuilder<FavoriteRecipesCubit, FavoriteRecipesState>(
        builder: (context, state) {
          if (state is InitFavoriteRecipesState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteRecipesLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.favoriteRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = state.favoriteRecipes[index];
                  return GestureDetector(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => RecipeDetailPage(
                                recipe: recipe,
                                recipeRepository: RecipeRepository(),
                              )),
                        ),
                      );
                    }),
                    child: Dismissible(
                      key: Key(recipe.label),
                      onDismissed: (direction) {
                        context
                            .read<FavoriteRecipesCubit>()
                            .deleteFavoriteRecipe(recipe);
                      },
                      background: Container(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Text(
                                "Remove",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.purple[100],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                isThreeLine: false,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                leading: Image.network(
                                  recipe.image,
                                  width: 100,
                                  height: 100,
                                ),
                                title: Text(
                                  recipe.label,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                  );
                },
              ),
            );
          } else if (state is FavoriteRecipesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}
