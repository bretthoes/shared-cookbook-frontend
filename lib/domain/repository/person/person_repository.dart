import 'dart:async';
import 'package:boilerplate/domain/usecase/person/login_usecase.dart';
import '../../entity/person/person.dart';

abstract class PersonRepository {
  Future<Person?> login(LoginParams params);

  Future<void> saveIsLoggedIn(bool value);

  Future<bool> get isLoggedIn;
}
