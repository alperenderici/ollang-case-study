import 'package:recipe_app/data/entity/recipe.dart';

abstract class FavoriteRecipesState {}

class InitFavoriteRecipesState extends FavoriteRecipesState {}

class FavoriteRecipesLoaded extends FavoriteRecipesState {
  final List<Recipe> favoriteRecipes;
  FavoriteRecipesLoaded(this.favoriteRecipes);
}

class ResponseFavoriteRecipesState extends FavoriteRecipesState {
  final List<Recipe> favoriteRecipes;
  ResponseFavoriteRecipesState(this.favoriteRecipes);
}

class FavoriteRecipeToggled extends FavoriteRecipesState {
  final Recipe updatedRecipe;
  FavoriteRecipeToggled(this.updatedRecipe);
}

class FavoriteRecipesError extends FavoriteRecipesState {
  final String message;
  FavoriteRecipesError(this.message);
}
