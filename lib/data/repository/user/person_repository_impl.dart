import 'dart:async';
import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/data/local/datasources/person/person_datasource.dart';
import 'package:boilerplate/data/network/apis/people/person_api.dart';
import 'package:boilerplate/domain/repository/person/person_repository.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:sembast/sembast.dart';
import '../../../domain/entity/person/person.dart';
import '../../../domain/usecase/person/login_usecase.dart';

class PersonRepositoryImpl extends PersonRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // data source object
  final PersonDataSource _personDataSource;

  // api objects
  final PersonApi _personApi;

  // constructor
  PersonRepositoryImpl(
    this._personApi,
    this._sharedPrefsHelper,
    this._personDataSource,
  );

  // Login:---------------------------------------------------------------------
  @override
  Future<Person?> login(LoginParams params) async {
    //return await Future.delayed(Duration(seconds: 2), () => Person());
    return await _personApi.login(params.email, params.password);
  }

  @override
  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  @override
  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  @override
  Future<Person?> findPersonById(int id) async {
    try {
      // TODO verify this works to store in local data source with 2 calls
      // first try and get from data source
      //creating filter
      List<Filter> filters = [];

      //check to see if dataLogsType is not null
      Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
      filters.add(dataLogTypeFilter);

      var personFromDb =
          await _personDataSource.getPersonById(filters: filters);
      if (personFromDb != null) {
        return personFromDb;
      }

      // if nothing in data source, fetch
      // from api and update data source
      var person = await _personApi.findPersonById(id);
      await _personDataSource.insert(person);
      return person;
    } catch (e) {
      throw e;
    }
  }
}
