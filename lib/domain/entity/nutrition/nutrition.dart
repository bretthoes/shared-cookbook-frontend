class RecipeNutrition {
  int? recipeNutritionId;
  int? recipeId;
  int? calories;
  int? protein;
  int? fat;
  int? carbohydrates;
  int? sugar;
  int? fiber;
  int? sodium;

  RecipeNutrition({
    this.recipeNutritionId,
    this.recipeId,
    this.calories,
    this.protein,
    this.fat,
    this.carbohydrates,
    this.sugar,
    this.fiber,
    this.sodium,
  });

  factory RecipeNutrition.fromMap(Map<String, dynamic> json) => RecipeNutrition(
        recipeNutritionId: json["recipeNutritionId"],
        recipeId: json["recipeId"],
        calories: json["calories"],
        protein: json["protein"],
        fat: json["fat"],
        carbohydrates: json["carbohydrates"],
        sugar: json["sugar"],
        fiber: json["fiber"],
        sodium: json["sodium"],
      );

  Map<String, dynamic> toMap() => {
        "recipeNutritionId": recipeNutritionId,
        "recipeId": recipeId,
        "calories": calories,
        "protein": protein,
        "fat": fat,
        "carbohydrates": carbohydrates,
        "sugar": sugar,
        "fiber": fiber,
        "sodium": sodium,
      };
}
