import 'package:bloc/bloc.dart';
import 'package:recipe_app/data/entity/recipe.dart';
import 'package:recipe_app/data/repo/recipe_repository.dart';
import 'package:recipe_app/ui/cubit/favorite_recipes_state.dart';

class FavoriteRecipesCubit extends Cubit<FavoriteRecipesState> {
  final RecipeRepository _repository;

  FavoriteRecipesCubit(this._repository) : super(InitFavoriteRecipesState());

  Future<void> loadFavoriteRecipes() async {
    try {
      final favoriteRecipes = await _repository.listFavRecipes();
      emit(ResponseFavoriteRecipesState(favoriteRecipes));
    } catch (e) {
      emit(FavoriteRecipesError('Failed to load favorite recipes: $e'));
    }
  }

  Future<void> addFavoriteRecipe(Recipe recipe) async {
    try {
      await _repository.addFavRecipe(recipe);
      emit(
        FavoriteRecipeToggled(
          recipe.copyWith(isFavorite: true),
        ),
      );
    } catch (e) {
      emit(
        FavoriteRecipesError('Failed to add favorite recipe: $e'),
      );
    }
  }

  // void toggleFavorite(
  //   Recipe recipe,
  // ) async {
  //   try {
  //     if (recipe.isFavorite) {
  //       await _repository.deleteFavRecipe(recipe);
  //     } else {
  //       await _repository.addFavRecipe(recipe);
  //     }
  //     final updatedRecipe = recipe.copyWith(isFavorite: !recipe.isFavorite);
  //     emit(
  //       FavoriteRecipeToggled(updatedRecipe),
  //     );
  //   } catch (e) {
  //     emit(
  //       FavoriteRecipesError('Failed to toggle favorite recipe: $e'),
  //     );
  //   }
  // }

  void deleteFavoriteRecipe(Recipe recipe) async {
    try {
      await _repository.deleteFavRecipe(recipe);
      emit(
        FavoriteRecipeToggled(
          recipe.copyWith(isFavorite: false),
        ),
      );
    } catch (e) {
      emit(
        FavoriteRecipesError('Failed to delete favorite recipe: $e'),
      );
    }
  }

  //search favorite recipes
  Future<void> searchFavoriteRecipes(String query) async {
    try {
      final favoriteRecipes = await _repository.searchFavRecipes(query);
      emit(
        ResponseFavoriteRecipesState(favoriteRecipes),
      );
    } catch (e) {
      emit(
        FavoriteRecipesError('Failed to search favorite recipes: $e'),
      );
    }
  }
}
