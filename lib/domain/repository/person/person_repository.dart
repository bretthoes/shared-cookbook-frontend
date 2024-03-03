import 'dart:async';
import 'package:boilerplate/domain/usecase/person/login_usecase.dart';
import 'package:boilerplate/domain/usecase/person/register_usecase.dart';
import '../../entity/person/person.dart';

abstract class PersonRepository {
  Future<Person?> findPersonById(int id);

  Future<Person?> findPersonByEmail(String email);

  Future<Person?> login(LoginParams params);

  Future<Person?> register(RegisterParams params);

  Future<void> saveIsLoggedIn(bool value);

  Future<bool> get isLoggedIn;
}
