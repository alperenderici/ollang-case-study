import 'package:recipe_app/data/repo/recipe_repository.dart';
import 'package:recipe_app/ui/cubit/homepage_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<HomepageState> {
  final RecipeRepository _recipeRepository;
  HomePageCubit(this._recipeRepository) : super(InitHomepageState());

  Future<void> getRecipes() async {
    emit(LoadingHomepageState());
    try {
      var response = await _recipeRepository.getRandomApiData();
      emit(ResponseHomepageState(response));
    } catch (e) {
      emit(ErrorHomepageState(e.toString()));
    }
  }

  Future<void> searchRecipes(String query) async {
    emit(LoadingHomepageState());
    try {
      var response = await _recipeRepository.searchApiData(query);
      emit(ResponseHomepageState(response));
    } catch (e) {
      emit(ErrorHomepageState(e.toString()));
    }
  }
}
