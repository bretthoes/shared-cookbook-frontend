class IngredientCategory {
  int? ingredientCategoryId;
  String? title;
  int? recipeId;

  IngredientCategory({
    this.ingredientCategoryId,
    this.title,
    this.recipeId,
  });

  factory IngredientCategory.fromMap(Map<String, dynamic> json) =>
      IngredientCategory(
        ingredientCategoryId: json["ingredientCategoryId"],
        title: json["title"],
        recipeId: json["recipeId"],
      );

  Map<String, dynamic> toMap() => {
        "ingredientCategoryId": ingredientCategoryId,
        "title": title,
        "recipeId": recipeId,
      };
}
