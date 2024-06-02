// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecipeStore on _RecipeStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_RecipeStore.loading'))
      .value;

  late final _$fetchRecipesFutureAtom =
      Atom(name: '_RecipeStore.fetchRecipesFuture', context: context);

  @override
  ObservableFuture<RecipeList?> get fetchRecipesFuture {
    _$fetchRecipesFutureAtom.reportRead();
    return super.fetchRecipesFuture;
  }

  @override
  set fetchRecipesFuture(ObservableFuture<RecipeList?> value) {
    _$fetchRecipesFutureAtom.reportWrite(value, super.fetchRecipesFuture, () {
      super.fetchRecipesFuture = value;
    });
  }

  late final _$fetchRecipeFutureAtom =
      Atom(name: '_RecipeStore.fetchRecipeFuture', context: context);

  @override
  ObservableFuture<Recipe?> get fetchRecipeFuture {
    _$fetchRecipeFutureAtom.reportRead();
    return super.fetchRecipeFuture;
  }

  @override
  set fetchRecipeFuture(ObservableFuture<Recipe?> value) {
    _$fetchRecipeFutureAtom.reportWrite(value, super.fetchRecipeFuture, () {
      super.fetchRecipeFuture = value;
    });
  }

  late final _$recipeListAtom =
      Atom(name: '_RecipeStore.recipeList', context: context);

  @override
  RecipeList get recipeList {
    _$recipeListAtom.reportRead();
    return super.recipeList;
  }

  @override
  set recipeList(RecipeList value) {
    _$recipeListAtom.reportWrite(value, super.recipeList, () {
      super.recipeList = value;
    });
  }

  late final _$selectedRecipeIndexAtom =
      Atom(name: '_RecipeStore.selectedRecipeIndex', context: context);

  @override
  int get selectedRecipeIndex {
    _$selectedRecipeIndexAtom.reportRead();
    return super.selectedRecipeIndex;
  }

  @override
  set selectedRecipeIndex(int value) {
    _$selectedRecipeIndexAtom.reportWrite(value, super.selectedRecipeIndex, () {
      super.selectedRecipeIndex = value;
    });
  }

  late final _$newCoverAtom =
      Atom(name: '_RecipeStore.newCover', context: context);

  @override
  String get newCover {
    _$newCoverAtom.reportRead();
    return super.newCover;
  }

  @override
  set newCover(String value) {
    _$newCoverAtom.reportWrite(value, super.newCover, () {
      super.newCover = value;
    });
  }

  late final _$getRecipesAsyncAction =
      AsyncAction('_RecipeStore.getRecipes', context: context);

  @override
  Future<dynamic> getRecipes(int cookbookId) {
    return _$getRecipesAsyncAction.run(() => super.getRecipes(cookbookId));
  }

  late final _$getRecipeDetailsAsyncAction =
      AsyncAction('_RecipeStore.getRecipeDetails', context: context);

  @override
  Future<dynamic> getRecipeDetails(int recipeId) {
    return _$getRecipeDetailsAsyncAction
        .run(() => super.getRecipeDetails(recipeId));
  }

  late final _$addRecipeAsyncAction =
      AsyncAction('_RecipeStore.addRecipe', context: context);

  @override
  Future<dynamic> addRecipe(int creatorPersonId, String title, String cover) {
    return _$addRecipeAsyncAction
        .run(() => super.addRecipe(creatorPersonId, title, cover));
  }

  late final _$_RecipeStoreActionController =
      ActionController(name: '_RecipeStore', context: context);

  @override
  String validateAddRecipe(int creatorPersonId, String title, String cover) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.validateAddRecipe');
    try {
      return super.validateAddRecipe(creatorPersonId, title, cover);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCover(String value) {
    final _$actionInfo = _$_RecipeStoreActionController.startAction(
        name: '_RecipeStore.setCover');
    try {
      return super.setCover(value);
    } finally {
      _$_RecipeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchRecipesFuture: ${fetchRecipesFuture},
fetchRecipeFuture: ${fetchRecipeFuture},
recipeList: ${recipeList},
selectedRecipeIndex: ${selectedRecipeIndex},
newCover: ${newCover},
loading: ${loading}
    ''';
  }
}

mixin _$RecipeErrorStore on _RecipeErrorStore, Store {
  late final _$errorAtom =
      Atom(name: '_RecipeErrorStore.error', context: context);

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$_RecipeErrorStoreActionController =
      ActionController(name: '_RecipeErrorStore', context: context);

  @override
  void resetError() {
    final _$actionInfo = _$_RecipeErrorStoreActionController.startAction(
        name: '_RecipeErrorStore.resetError');
    try {
      return super.resetError();
    } finally {
      _$_RecipeErrorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error}
    ''';
  }
}
