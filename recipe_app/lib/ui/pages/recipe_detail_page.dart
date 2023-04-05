import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/data/entity/recipe.dart';
import 'package:recipe_app/data/repo/recipe_repository.dart';
import 'package:recipe_app/ui/cubit/favorite_recipes_cubit.dart';
import 'package:recipe_app/ui/cubit/favorite_recipes_state.dart';

class RecipeDetailPage extends StatefulWidget {
  Recipe recipe;

  RecipeDetailPage({
    Key? key,
    required this.recipe,
    required RecipeRepository recipeRepository,
  }) : super(key: key);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late bool _isFav;

  @override
  void initState() {
    super.initState();
    checkIfFav();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<FavoriteRecipesCubit>();
      cubit.loadFavoriteRecipes();
    });
    _isFav = widget.recipe.isFavorite;
  }

  void checkIfFav() {
    final cubit = context.read<FavoriteRecipesCubit>();
    cubit.loadFavoriteRecipes();
    if (cubit.state is FavoriteRecipesLoaded) {
      final state = cubit.state as FavoriteRecipesLoaded;
      for (var recipe in state.favoriteRecipes) {
        if (recipe.label == widget.recipe.label) {
          _isFav = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.recipe.label),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isFav = !_isFav;
                // context
                //     .read<FavoriteRecipesCubit>()
                //     .addFavoriteRecipe(widget.recipe);
                context
                    .read<FavoriteRecipesCubit>()
                    .toggleFavorite(widget.recipe);
              });
            },
            icon: _isFav
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              color: Colors.deepPurple[100],
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        widget.recipe.image,
                        width: MediaQuery.of(context).size.width / 1.5,
                        fit: BoxFit.cover,
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.recipe.label,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.purple[100],
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Ingredients",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.recipe.ingredients?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              isThreeLine: false,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              leading: Image.network(
                                widget.recipe.ingredients![index]['image']
                                    .toString(),
                              ),
                              subtitle: Text(
                                widget
                                    .recipe.ingredients![index]['foodCategory']
                                    .toString(),
                              ),
                              title: Text(
                                widget.recipe.ingredients![index]['text']
                                    .toString(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.pink[100],
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Ingredient Lines",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.recipe.ingredientLines?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${index + 1}. ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.recipe.ingredientLines![index],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
