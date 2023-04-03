import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_app/data/entity/recipe.dart';

class RecipeRepository {
  //Recipe Search API
  // final app_id = "7f9c315e";
  // final app_key = "f191e18006552fc1611655e94b4d96ec";

  final baseUrl =
      "https://api.edamam.com/api/recipes/v2?type=public&app_id=7f9c315e&app_key=f191e18006552fc1611655e94b4d96ec&imageSize=LARGE";

//list of recipes
  Future<List<Recipe>> getRandomApiData() async {
    final url = "$baseUrl&random=true";
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

  Future<List<Recipe>> searchApiData(String searchword) async {
    final url = "$baseUrl&q=$searchword&random=false&to=20";
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

  // Future<List<Recipe>> searchApiData(String searchword) async {
  //   final maxResults = 100;
  //   final recipes = <Recipe>[];
  //   int from = 0;

  //   while (true) {
  //     final url =
  //         '$baseUrl&q=$searchword&random=false&from=$from&to=${from + 20}';
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       final json = jsonDecode(response.body) as Map<String, dynamic>;
  //       final results = json['hits'] as List<dynamic>;
  //       final newRecipes = results.map((result) {
  //         final recipe = result['recipe'] as Map<String, dynamic>;
  //         final label = recipe['label'] as String;
  //         final image = recipe['image'] as String;
  //         final url = recipe['url'] as String;
  //         final ingredientLines = List<String>.from(recipe['ingredientLines']);
  //         return Recipe(
  //           label: label,
  //           image: image,
  //           url: url,
  //           ingredientLines: ingredientLines,
  //         );
  //       }).toList();
  //       recipes.addAll(newRecipes);
  //       if (newRecipes.length < 20 || recipes.length >= maxResults) {
  //         break; // no more recipes to fetch
  //       }
  //       from += 20;
  //     } else {
  //       throw Exception('Failed to load data ${response.statusCode}');
  //     }
  //   }
  //   return recipes;
  // }

}//class bracet
