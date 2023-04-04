import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/data/entity/recipe.dart';
import 'package:recipe_app/data/sqlite/database.dart';

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
        final ingredients =
            List<Map<String, dynamic>>.from(recipe['ingredients']);
        final ingredientLines = List<String>.from(recipe['ingredientLines']);
        const isFavorite = false;
        return Recipe(
          label: label,
          image: image,
          ingredients: ingredients,
          ingredientLines: ingredientLines,
          isFavorite: isFavorite,
        );
      }).toList();
      return recipes;
    } else {
      throw Exception('Failed to load data ${response.statusCode}');
    }
  }

  Future<List<Recipe>> searchApiData(String searchword) async {
    final url = "$baseUrl&q=$searchword";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final results = json['hits'] as List<dynamic>;
      final recipes = results.map((result) {
        final recipe = result['recipe'] as Map<String, dynamic>;
        final label = recipe['label'] as String;
        final image = recipe['image'] as String;
        final ingredients =
            List<Map<String, dynamic>>.from(recipe['ingredients']);
        final ingredientLines = List<String>.from(recipe['ingredientLines']);
        const isFavorite = false;
        return Recipe(
          label: label,
          image: image,
          ingredients: ingredients,
          ingredientLines: ingredientLines,
          isFavorite: isFavorite,
        );
      }).toList();
      return recipes;
    } else {
      throw Exception('Failed to load data ${response.statusCode}');
    }
  }

  // add favorite recipe
  Future<void> addFavRecipe(Recipe recipe) async {
    var db = await DB.connectDB();
    await db.insert('favs', {
      'recipe_label': recipe.label,
      'recipe_image': recipe.image,
      'recipe_ingredients': jsonEncode(recipe.ingredients),
      'recipe_ingredientLines': jsonEncode(recipe.ingredientLines),
    });
  }

  // delete favorite recipe
  Future<void> deleteFavRecipe(Recipe recipe) async {
    var db = await DB.connectDB();
    await db
        .delete('favs', where: 'recipe_label = ?', whereArgs: [recipe.label]);
  }

  // list favorite recipes
  Future<List<Recipe>> listFavRecipes() async {
    var db = await DB.connectDB();
    List<Map<String, dynamic>> favs = await db.rawQuery("SELECT * FROM favs");
    return List.generate(favs.length, (index) {
      var map = favs[index];
      return Recipe(
        label: map["recipe_label"],
        image: map["recipe_image"],
        ingredients: jsonDecode(map["recipe_ingredients"]),
        ingredientLines: jsonDecode(map["recipe_ingredientLines"]),
        isFavorite: true,
      );
    });
  }

  //search favorite recipes
  Future<List<Recipe>> searchFavRecipes(String searchword) async {
    var db = await DB.connectDB();
    List<Map<String, dynamic>> maps = await db
        .rawQuery("SELECT * FROM favs WHERE recipe_label LIKE '%$searchword%'");
    return List.generate(maps.length, (index) {
      var line = maps[index];
      return Recipe(
        label: line["recipe_label"],
        image: line["recipe_image"],
        ingredients: jsonDecode(line["recipe_ingredients"]),
        ingredientLines: jsonDecode(line["recipe_ingredientLines"]),
        isFavorite: true,
      );
    });
  }
}//class bracet

