import 'dart:async';
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook_list.dart';

class CookbookApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  CookbookApi(this._dioClient);

  /// Returns list of post in response
  Future<CookbookList> getCookbooks(int personId) async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getCookbooks(personId));
      return CookbookList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
