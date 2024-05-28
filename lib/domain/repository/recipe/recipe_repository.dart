import 'dart:async';
import 'package:boilerplate/domain/entity/recipe/recipe.dart';
import 'package:boilerplate/domain/entity/recipe/recipe_list.dart';
import 'package:boilerplate/domain/usecase/recipe/add_recipe_usecase.dart';

abstract class RecipeRepository {
  Future<RecipeList> getRecipes(int cookbookId);

  Future<Recipe?> findRecipeById(int id);

  Future<Recipe?> add(AddRecipeParams recipe);

  Future<int> update(Recipe recipe);

  Future<int> delete(Recipe recipe);
}
