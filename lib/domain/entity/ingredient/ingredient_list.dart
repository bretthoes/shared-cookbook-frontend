import 'package:boilerplate/domain/entity/ingredient/ingredient.dart';

class IngredientList {
  final List<Ingredient> ingredient;

  IngredientList({
    required this.ingredient,
  });

  factory IngredientList.fromJson(List<dynamic> json) {
    var ingredients =
        json.map((ingredient) => Ingredient.fromMap(ingredient)).toList();

    return IngredientList(
      ingredient: ingredients,
    );
  }
}
