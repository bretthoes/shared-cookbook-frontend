import 'dart:async';
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/person/person.dart';

class PersonApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  PersonApi(this._dioClient);

  Future<Person> login(String email, String password) async {
    try {
      var person = new Person(email: email, password: password);
      final res = await _dioClient.dio.post(
        Endpoints.postLogin,
        data: person.toMap(),
      );
      return Person.fromMap(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Person> register(String email, String password) async {
    try {
      var person = new Person(email: email, password: password);
      final res = await _dioClient.dio.post(
        Endpoints.addPerson,
        data: person.toMap(),
      );
      return Person.fromMap(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Person> findPersonById(int id) async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getPerson(id));
      return Person.fromMap(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Person?> findPersonByEmail(String email) async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getPersonByEmail(email));
      var person = Person.fromMap(res.data);
      return person;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
