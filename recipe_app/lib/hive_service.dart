import "package:hive/hive.dart";

class LocalStorage {
  // static Future<void> addFavRecipe(String value) async {
  //   Box box = await Hive.openBox("favRecipe");
  //   box.add(value);
  // }

  static Future<List<String>> searchFavRecipes(String query) async {
    Box<String> box = await Hive.openBox<String>("favRecipe");
    List<String> favRecipes = box.values
        .where((recipe) => recipe.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return favRecipes;
  }

  static Future<void> addFavRecipe(String value) async {
    Box<String> box = await Hive.openBox<String>("favRecipe");
    box.add(value);
  }

  static Future<List<String>> getFavRecipes() async {
    Box<String> box = await Hive.openBox<String>("favRecipe");
    List<String> favRecipes = box.values.toList();
    return favRecipes;
  }

  static Future<void> deleteFavRecipe(String value) async {
    Box box = await Hive.openBox("favRecipe");
    box.delete(value);
  }
}
