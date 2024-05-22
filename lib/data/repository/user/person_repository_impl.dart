import 'dart:async';
import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/data/local/datasources/person/person_datasource.dart';
import 'package:boilerplate/data/network/apis/people/person_api.dart';
import 'package:boilerplate/domain/repository/person/person_repository.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/usecase/person/register_usecase.dart';
import 'package:boilerplate/domain/usecase/person/update_person_usecase.dart';
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

  static const bool _cacheEnabled = false;

  // constructor
  PersonRepositoryImpl(
    this._personApi,
    this._sharedPrefsHelper,
    this._personDataSource,
  );

  // Login:---------------------------------------------------------------------
  @override
  Future<Person?> login(LoginParams params) async {
    return await _personApi.login(params);
  }

  @override
  Future<Person?> register(RegisterParams params) async {
    return await _personApi.register(params);
  }

  @override
  Future<Person?> updatePerson(UpdatePersonParams params) async {
    return await _personApi.patch(
      params.personId,
      params.displayName,
      params.imagePath,
      params.password,
    );
  }

  @override
  Future<bool> savePersonId(int value) =>
      _sharedPrefsHelper.savePersonId(value);

  @override
  Future<int> get personId => _sharedPrefsHelper.personId;

  @override
  Future<Person?> findPersonById(int id) async {
    try {
      if (_cacheEnabled) {
        List<Filter> filters = [];
        Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
        filters.add(dataLogTypeFilter);

        var personFromDb =
            await _personDataSource.getPersonById(filters: filters);
        if (personFromDb != null) {
          return personFromDb;
        }
      }

      var personFromApi = await _personApi.findPersonById(id);

      if (_cacheEnabled) {
        await _personDataSource.insert(personFromApi);
      }

      return personFromApi;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Person?> findPersonByEmail(String email) async {
    try {
      if (_cacheEnabled) {
        List<Filter> filters = [];
        Filter dataLogTypeFilter =
            Filter.equals(DBConstants.FIELD_EMAIL, email);
        filters.add(dataLogTypeFilter);

        var personFromDb =
            await _personDataSource.getPersonByEmail(filters: filters);
        if (personFromDb != null) {
          return personFromDb;
        }
      }

      var personFromApi = await _personApi.findPersonByEmail(email);

      if (_cacheEnabled && personFromApi != null) {
        await _personDataSource.insert(personFromApi);
      }

      return personFromApi;
    } catch (e) {
      throw e;
    }
  }
}
