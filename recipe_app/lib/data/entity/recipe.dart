// ignore_for_file: public_member_api_docs, sort_constructors_first
class Recipe {
  final String label;
  final String image;
  final List<Map<String, dynamic>> ingredients;
  final List<String> ingredientLines;
  final bool isFavorite;

  Recipe({
    required this.label,
    required this.image,
    required this.ingredients,
    required this.ingredientLines,
    required this.isFavorite,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    final recipe = json['recipe'] as Map<String, dynamic>;
    final label = recipe['label'] as String;
    final image = recipe['image'] as String;
    final ingredients = List<Map<String, dynamic>>.from(recipe['ingredients']);
    final ingredientLines = List<String>.from(recipe['ingredientLines']);
    return Recipe(
      label: label,
      image: image,
      ingredients: ingredients,
      ingredientLines: ingredientLines,
      isFavorite: false,
    );
  }

  Recipe copyWith({
    String? label,
    String? image,
    List<Map<String, dynamic>>? ingredients,
    List<String>? ingredientLines,
    bool? isFavorite,
  }) {
    return Recipe(
      label: label ?? this.label,
      image: image ?? this.image,
      ingredients: ingredients ?? this.ingredients,
      ingredientLines: ingredientLines ?? this.ingredientLines,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
