import 'dart:async';

import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/data/local/datasources/recipe/recipe_datasource.dart';
import 'package:boilerplate/data/network/apis/recipes/recipe_api.dart';
import 'package:boilerplate/domain/entity/recipe/recipe.dart';
import 'package:boilerplate/domain/entity/recipe/recipe_list.dart';
import 'package:boilerplate/domain/repository/recipe/recipe_repository.dart';
import 'package:boilerplate/domain/usecase/recipe/add_recipe_usecase.dart';
import 'package:sembast/sembast.dart';

class RecipeRepositoryImpl extends RecipeRepository {
  // data source object
  final RecipeDataSource _recipeDataSource;

  // api objects
  final RecipeApi _recipeApi;

  static const bool _cacheEnabled = false;

  // constructor
  RecipeRepositoryImpl(this._recipeApi, this._recipeDataSource);

  // Cookbook: ---------------------------------------------------------------------
  @override
  Future<RecipeList> getRecipes(int cookbookId) async {
    if (_cacheEnabled) {
      //creating filter
      List<Filter> filters = [];

      //check to see if dataLogsType is not null
      Filter dataLogTypeFilter =
          Filter.equals(DBConstants.RECIPE_ID, cookbookId);
      filters.add(dataLogTypeFilter);

      var recipesFromDb = await _recipeDataSource
          .getAllSortedByFilter(filters: filters)
          .then((recipes) => recipes)
          .catchError((error) => throw error);

      if (recipesFromDb.isNotEmpty) {
        return new RecipeList(recipes: recipesFromDb);
      }
    }

    var recipesFromApi = await _recipeApi.getRecipes(cookbookId);

    if (_cacheEnabled) {
      for (var recipe in recipesFromApi.recipes) {
        await _recipeDataSource.insert(recipe);
      }
    }

    return recipesFromApi;
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.RECIPE_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _recipeDataSource
        .getAllSortedByFilter(filters: filters)
        .then((recipes) => recipes.first)
        .catchError((error) => throw error);
  }

  @override
  Future<Recipe?> add(AddRecipeParams params) async {
    var newRecipe = await _recipeApi.addRecipe(params);

    return _recipeDataSource
        .insert(newRecipe)
        .then((recipe) => recipe)
        .catchError((error) => throw error);
  }

  @override
  Future<int> update(Recipe recipe) => _recipeDataSource
      .update(recipe)
      .then((id) => id)
      .catchError((error) => throw error);

  @override
  Future<int> delete(Recipe recipe) => _recipeDataSource
      .update(recipe)
      .then((id) => id)
      .catchError((error) => throw error);
}
