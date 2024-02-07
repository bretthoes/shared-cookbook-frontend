import 'dart:async';

import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/data/local/datasources/cookbook/cookbook_datasource.dart';
import 'package:boilerplate/data/network/apis/cookbooks/cookbook_api.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook_list.dart';
import 'package:boilerplate/domain/repository/cookbook/cookbook_repository.dart';
import 'package:sembast/sembast.dart';

class CookbookRepositoryImpl extends CookbookRepository {
  // data source object
  final CookbookDataSource _cookbookDataSource;

  // api objects
  final CookbookApi _cookbookApi;

  // constructor
  CookbookRepositoryImpl(this._cookbookApi, this._cookbookDataSource);

  // Cookbook: ---------------------------------------------------------------------
  @override
  Future<CookbookList> getCookbooks(int personId) async {
    // check to see if cookbooks are present in database, then fetch from database
    // else make a network call to get all cookbooks, store them into database for
    // later use
    return await _cookbookApi.getCookbooks(personId).then((cookbooks) {
      cookbooks.cookbooks?.forEach((cookbook) {
        _cookbookDataSource.insert(cookbook);
      });

      return cookbooks;
    }).catchError((error) => throw error);
  }

  @override
  Future<List<Cookbook>> findCookbookById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _cookbookDataSource
        .getAllSortedByFilter(filters: filters)
        .then((cookbooks) => cookbooks)
        .catchError((error) => throw error);
  }

  @override
  Future<int> insert(Cookbook cookbook) => _cookbookDataSource
      .insert(cookbook)
      .then((id) => id)
      .catchError((error) => throw error);

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
