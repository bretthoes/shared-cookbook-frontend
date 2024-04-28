import 'dart:async';
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook_list.dart';
import 'package:boilerplate/domain/usecase/cookbook/insert_cookbook_usecase.dart';

class CookbookApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  CookbookApi(this._dioClient);

  // Returns list of cookbooks in response
  Future<CookbookList> getCookbooks(int personId) async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getCookbooks(personId));
      return CookbookList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Adds a cookbook
  Future<Cookbook> addCookbook(InsertCookbookParams params) async {
    try {
      var cookbook = new Cookbook(
        creatorPersonId: params.creatorPersonId,
        title: params.title,
        imagePath: params.imagePath,
      );
      final res = await _dioClient.dio.post(
        Endpoints.addCookbook,
        data: cookbook.toMap(),
      );
      var newCookbook = Cookbook.fromMap(res.data);
      return newCookbook;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
