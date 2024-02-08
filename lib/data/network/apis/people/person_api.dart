import 'dart:async';
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/person/person.dart';

class PersonApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  PersonApi(this._dioClient);

  /// Returns list of post in response
  Future<Person> login(String email, String password) async {
    try {
      final res =
          await _dioClient.dio.get(Endpoints.postLogin(email, password));
      return Person.fromMap(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
