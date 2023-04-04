import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/ui/cubit/favorite_recipes_cubit.dart';
import 'package:recipe_app/ui/cubit/homepage_cubit.dart';
import 'package:recipe_app/ui/cubit/homepage_state.dart';
import 'package:recipe_app/ui/pages/favorite_recipes_page.dart';
import 'package:recipe_app/ui/pages/recipe_detail_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isSearch = false;
  bool isFav = false;
  bool isFavSelected = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<HomePageCubit>();
      cubit.getRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[100],
        appBar: AppBar(
          title: isSearch
              ? TextField(
                  decoration: const InputDecoration(hintText: "Search Recipe"),
                  onChanged: (searchResult) {
                    context.read<HomePageCubit>().searchRecipes(searchResult);
                  },
                )
              : const Text(
                  "Recipes",
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
                      });
                    },
                    icon: const Icon(Icons.search),
                  ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const FavoriteRecipesPage()),
                  ),
                ).then(
                  (value) => context
                      .read<FavoriteRecipesCubit>()
                      .loadFavoriteRecipes(),
                );
              },
              icon: const Icon(Icons.favorite_border),
            ),
            IconButton(
              onPressed: () {
                context.read<HomePageCubit>().getRecipes();
              },
              icon: const Icon(Icons.refresh_rounded),
            ),
          ],
        ),
        body: BlocBuilder<HomePageCubit, HomepageState>(
          builder: (context, state) {
            if (state is InitHomepageState || state is LoadingHomepageState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ResponseHomepageState) {
              final recipes = state.recipes;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: recipes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => RecipeDetailPage(
                                  recipe: recipes[index],
                                )),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Image.network(
                                  recipes[index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  recipes[index].label,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is ErrorHomepageState) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text(state.toString()));
          },
        ));
  }
}
