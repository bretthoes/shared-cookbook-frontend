import 'package:boilerplate/domain/entity/recipe/recipe.dart';

class RecipeList {
  final List<Recipe> recipes;

  RecipeList({
    required this.recipes,
  });

  factory RecipeList.fromJson(List<dynamic> json) {
    var recipes = json.map((recipe) => Recipe.fromMap(recipe)).toList();
    ;

    return RecipeList(
      recipes: recipes,
    );
  }
}
