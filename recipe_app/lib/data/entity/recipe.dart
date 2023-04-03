class Recipe {
  final String label;
  final String image;
  final String url;
  final List<String> ingredientLines;

  Recipe({
    required this.label,
    required this.image,
    required this.url,
    required this.ingredientLines,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    final recipe = json['recipe'] as Map<String, dynamic>;
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
  }
}
