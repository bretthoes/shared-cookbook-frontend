class Ingredient {
  int? recipeIngredientId;
  int? recipeId;
  String? ingredientName;
  int? ordinal;
  bool? optional;

  Ingredient({
    this.recipeIngredientId,
    this.recipeId,
    this.ingredientName,
    this.ordinal,
    this.optional,
  });

  factory Ingredient.fromMap(Map<String, dynamic> json) => Ingredient(
        recipeIngredientId: json["recipeIngredientId"],
        recipeId: json["recipeId"],
        ingredientName: json["ingredientName"],
        ordinal: json["ordinal"],
        optional: json["optional"],
      );

  Map<String, dynamic> toMap() => {
        "recipeIngredientId": recipeIngredientId,
        "recipeId": recipeId,
        "ingredientName": ingredientName,
        "ordinal": ordinal,
        "optional": optional,
      };
}
