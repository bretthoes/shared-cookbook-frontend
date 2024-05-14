import 'package:boilerplate/core/data/local/sembast/sembast_client.dart';
import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/domain/entity/recipe/recipe.dart';
import 'package:boilerplate/domain/entity/recipe/recipe_list.dart';
import 'package:sembast/sembast.dart';

class RecipeDataSource {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _recipesStore = intMapStoreFactory.store(DBConstants.STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
//  Future<Database> get _db async => await AppDatabase.instance.database;

  // database instance
  final SembastClient _sembastClient;

  // Constructor
  RecipeDataSource(this._sembastClient);

  // DB functions:--------------------------------------------------------------
  Future<Recipe> insert(Recipe recipe) async {
    await _recipesStore.add(_sembastClient.database, recipe.toMap());
    return recipe;
  }

  Future<int> count() async {
    return await _recipesStore.count(_sembastClient.database);
  }

  Future<List<Recipe>> getAllSortedByFilter({List<Filter>? filters}) async {
    //creating finder
    final finder = Finder(
        filter: filters != null ? Filter.and(filters) : null,
        sortOrders: [SortOrder(DBConstants.RECIPE_ID)]);

    final recordSnapshots = await _recipesStore.find(
      _sembastClient.database,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final recipe = Recipe.fromMap(snapshot.value);
      recipe.recipeId = snapshot.key;
      return recipe;
    }).toList();
  }

  Future<RecipeList> getRecipesFromDb() async {
    print('Loading from database');

    // cookbook list
    var recipeList;

    // fetching data
    final recordSnapshots = await _recipesStore.find(
      _sembastClient.database,
    );

    if (recordSnapshots.length > 0) {
      recipeList = RecipeList(
          recipes: recordSnapshots.map((snapshot) {
        final recipe = Recipe.fromMap(snapshot.value);
        // An ID is a key of a record from the database.
        recipe.recipeId = snapshot.key;
        return recipe;
      }).toList());
    }

    return recipeList;
  }

  Future<int> update(Recipe recipe) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(recipe.recipeId));
    return await _recipesStore.update(
      _sembastClient.database,
      recipe.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(Recipe recipe) async {
    final finder = Finder(filter: Filter.byKey(recipe.recipeId));
    return await _recipesStore.delete(
      _sembastClient.database,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _recipesStore.drop(
      _sembastClient.database,
    );
  }
}
