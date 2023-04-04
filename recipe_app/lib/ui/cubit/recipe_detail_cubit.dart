import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/data/repo/recipe_repository.dart';
import 'package:recipe_app/ui/cubit/recipe_detail_state.dart';

class RecipeDetailCubit extends Cubit<RecipeDetailState> {
  final RecipeRepository _recipeRepository;
  RecipeDetailCubit(this._recipeRepository) : super(RecipeDetailInitial());

  void getRecipeDetail(String recipeId) {
    emit(RecipeDetailLoading());
    //TODO GET RECIPE DETAIL

    emit(RecipeDetailLoaded(recipeId));
  }

  void addToFavorite(String recipeId) {
    emit(RecipeDetailLoading());
    //TODO ADD TO FAVORITE

    emit(RecipeDetailLoaded(recipeId));
  }
}
