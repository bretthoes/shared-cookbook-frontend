import 'dart:async';
import 'package:boilerplate/data/network/apis/people/person_api.dart';
import 'package:boilerplate/domain/repository/person/person_repository.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import '../../../domain/entity/person/person.dart';
import '../../../domain/usecase/person/login_usecase.dart';

class PersonRepositoryImpl extends PersonRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // api objects
  final PersonApi _personApi;

  // constructor
  PersonRepositoryImpl(this._personApi, this._sharedPrefsHelper);

  // Login:---------------------------------------------------------------------
  @override
  Future<Person?> login(LoginParams params) async {
    //return await Future.delayed(Duration(seconds: 2), () => Person());
    return await _personApi.login(params.username, params.password);
  }

  @override
  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  @override
  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;
}
