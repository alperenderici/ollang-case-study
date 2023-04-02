import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/data/entity/recipe.dart';

class RecipeRepository {
  //Recipe Search API
  // final app_id = "7f9c315e";
  // final app_key = "f191e18006552fc1611655e94b4d96ec";
  final url =
      "https://api.edamam.com/api/recipes/v2?type=public&app_id=7f9c315e&app_key=f191e18006552fc1611655e94b4d96ec&imageSize=LARGE&random=true";

//list of recipes
  Future<List<Recipe>> getApiData() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final results = json['hits'] as List<dynamic>;
      final recipes = results.map((result) {
        final recipe = result['recipe'] as Map<String, dynamic>;
        final label = recipe['label'] as String;
        final image = recipe['image'] as String;
        final url = recipe['url'] as String;
        final ingredientLines = List<String>.from(recipe['ingredientLines']);
        return Recipe(
          label: label,
          image: image,
          url: url,
          ingredientLines: ingredientLines,
        );
      }).toList();
      return recipes;
    } else {
      throw Exception('Failed to load data ${response.statusCode}');
    }
  }

//search

//favorite

}
