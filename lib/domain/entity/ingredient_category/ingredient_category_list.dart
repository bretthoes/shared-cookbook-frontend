import 'package:boilerplate/domain/entity/ingredient_category/ingredient_category.dart';

class IngredientCategoryList {
  final List<IngredientCategory> ingredientCategories;

  IngredientCategoryList({
    required this.ingredientCategories,
  });

  factory IngredientCategoryList.fromJson(List<dynamic> json) {
    var ingredientCategories =
        json.map((category) => IngredientCategory.fromMap(category)).toList();

    return IngredientCategoryList(
      ingredientCategories: ingredientCategories,
    );
  }
}
