import 'package:boilerplate/core/extensions/string_extension.dart';
import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/recipe/recipe_list.dart';
import 'package:boilerplate/domain/usecase/recipe/add_recipe_usecase.dart';
import 'package:boilerplate/domain/usecase/recipe/get_recipe_usecase.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'recipe_store.g.dart';

class RecipeStore = _RecipeStore with _$RecipeStore;

abstract class _RecipeStore with Store {
  // constructor:---------------------------------------------------------------
  _RecipeStore(
    this._getRecipeUseCase,
    this._addRecipeUseCase,
    this.errorStore,
    this.recipeErrorStore,
  );

  // use cases:-----------------------------------------------------------------
  final GetRecipeUseCase _getRecipeUseCase;
  final AddRecipeUseCase _addRecipeUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;
  final RecipeErrorStore recipeErrorStore;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<RecipeList?> emptyRecipeResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<RecipeList?> fetchRecipesFuture =
      ObservableFuture<RecipeList?>(emptyRecipeResponse);

  @observable
  RecipeList recipeList = new RecipeList(recipes: new List.empty());

  @observable
  String newCover = '';

  @computed
  bool get loading => fetchRecipesFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getRecipes(int cookbookId) async {
    final future = _getRecipeUseCase.call(params: cookbookId);
    fetchRecipesFuture = ObservableFuture(future);

    await future.then((recipeList) {
      this.recipeList = recipeList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getRecipeDetails(int recipeId) async {
    final future = _getRecipeUseCase.call(params: recipeId);
    fetchRecipesFuture = ObservableFuture(future);

    await future.then((recipeList) {
      this.recipeList = recipeList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future addRecipe(
    int creatorPersonId,
    String title,
    String cover,
  ) async {
    recipeErrorStore.error = validateAddRecipe(
      creatorPersonId,
      title,
      cover,
    );
    if (recipeErrorStore.error.isNotEmpty) {
      return;
    }

    final params = AddRecipeParams(
      creatorPersonId: creatorPersonId,
      title: title,
      imagePath: cover,
    );
    final future = _addRecipeUseCase.call(params: params);

    await future.then((addedRecipe) {
      if (addedRecipe == null) {
        throw Exception("Failed to add recipe: returned recipe is null");
      }
      recipeList.recipes.add(addedRecipe);
      getRecipes(creatorPersonId);
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  String validateAddRecipe(int creatorPersonId, String title, String cover) {
    var error = "";

    if (creatorPersonId <= 0) {
      error = "please sign in first";
      return error;
    }
    if (title.isNullOrWhitespace) {
      error = "please add a title";
      return error;
    }
    if (cover.isNullOrWhitespace) {
      error = "please add a cover image";
      return error;
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(title)) {
      error = "only alphanumeric characters allowed";
      return error;
    }
    if (title.length < 2 || title.length > 18) {
      error = "must be 2-18 chars";
      return error;
    }

    return error;
  }

  @action
  void setCover(String value) {
    newCover = value;
  }
}

class RecipeErrorStore = _RecipeErrorStore with _$RecipeErrorStore;

abstract class _RecipeErrorStore with Store {
  @observable
  String error = '';

  @action
  void resetError() {
    error = '';
  }
}
