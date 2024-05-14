import 'dart:async';
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/recipe/recipe.dart';
import 'package:boilerplate/domain/entity/recipe/recipe_list.dart';
import 'package:boilerplate/domain/usecase/recipe/add_recipe_usecase.dart';

class RecipeApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  RecipeApi(this._dioClient);

  Future<RecipeList> getRecipes(int cookbookId) async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getRecipes(cookbookId));
      return RecipeList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Recipe> addRecipe(AddRecipeParams params) async {
    try {
      var recipe = new Recipe(
        title: params.title,
        imagePath: params.imagePath,
      );
      final res = await _dioClient.dio.post(
        Endpoints.addRecipe,
        data: recipe.toMap(),
      );
      var newRecipe = Recipe.fromMap(res.data);
      return newRecipe;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
