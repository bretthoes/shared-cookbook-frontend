import 'dart:async';
import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/data/local/datasources/cookbook/cookbook_datasource.dart';
import 'package:boilerplate/data/network/apis/cookbooks/cookbook_api.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook_list.dart';
import 'package:boilerplate/domain/repository/cookbook/cookbook_repository.dart';
import 'package:boilerplate/domain/usecase/cookbook/add_cookbook_usecase.dart';
import 'package:sembast/sembast.dart';

class CookbookRepositoryImpl extends CookbookRepository {
  // data source object
  final CookbookDataSource _cookbookDataSource;

  // api objects
  final CookbookApi _cookbookApi;

  static const bool _cacheEnabled = false;

  // constructor
  CookbookRepositoryImpl(this._cookbookApi, this._cookbookDataSource);

  // Cookbook: ---------------------------------------------------------------------
  @override
  Future<CookbookList> getCookbooks(int personId) async {
    //creating filter
    if (_cacheEnabled) {
      List<Filter> filters = [];

      //check to see if dataLogsType is not null
      Filter dataLogTypeFilter =
          Filter.equals(DBConstants.CREATOR_PERSON_ID, personId);
      filters.add(dataLogTypeFilter);

      var cookbooksFromDb = await _cookbookDataSource
          .getAllSortedByFilter(filters: filters)
          .then((cookbooks) => cookbooks)
          .catchError((error) => throw error);

      if (cookbooksFromDb.isNotEmpty) {
        return new CookbookList(cookbooks: cookbooksFromDb);
      }
    }

    var cookbooksFromApi = await _cookbookApi.getCookbooks(personId);

    if (_cacheEnabled) {
      for (var cookbook in cookbooksFromApi.cookbooks) {
        await _cookbookDataSource.insert(cookbook);
      }
    }

    return cookbooksFromApi;
  }

  @override
  Future<List<Cookbook>> findCookbookById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.CREATOR_PERSON_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _cookbookDataSource
        .getAllSortedByFilter(filters: filters)
        .then((cookbooks) => cookbooks)
        .catchError((error) => throw error);
  }

  @override
  Future<Cookbook?> add(AddCookbookParams params) async {
    var newCookbook = await _cookbookApi.addCookbook(params);

    return _cookbookDataSource
        .insert(newCookbook)
        .then((cookbook) => cookbook)
        .catchError((error) => throw error);
  }

  @override
  Future<int> update(Cookbook cookbook) => _cookbookDataSource
      .update(cookbook)
      .then((id) => id)
      .catchError((error) => throw error);

  @override
  Future<int> delete(Cookbook cookbook) => _cookbookDataSource
      .update(cookbook)
      .then((id) => id)
      .catchError((error) => throw error);
}
