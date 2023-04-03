class Recipe {
  final String label;
  final String image;
  final List<Map<String, dynamic>> ingredients;
  final List<String> ingredientLines;

  Recipe({
    required this.label,
    required this.image,
    required this.ingredients,
    required this.ingredientLines,
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
    );
  }
}
