import 'package:recipe_app/data/entity/recipe.dart';

abstract class HomepageState {}

class InitHomepageState extends HomepageState {}

class LoadingHomepageState extends HomepageState {}

class ErrorHomepageState extends HomepageState {
  final String message;
  ErrorHomepageState(this.message);
}

class ResponseHomepageState extends HomepageState {
  final List<Recipe> recipes;
  ResponseHomepageState(this.recipes);
}
