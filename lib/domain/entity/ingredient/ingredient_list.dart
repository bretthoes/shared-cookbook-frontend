import 'package:boilerplate/domain/entity/ingredient/ingredient.dart';

class IngredientList {
  final List<Ingredient> ingredients;

  IngredientList({
    required this.ingredients,
  });

  factory IngredientList.fromJson(List<dynamic> json) {
    var ingredients =
        json.map((ingredient) => Ingredient.fromMap(ingredient)).toList();

    return IngredientList(
      ingredients: ingredients,
    );
  }
}
