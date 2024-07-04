import 'dart:async';
import 'dart:io';
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook_list.dart';
import 'package:boilerplate/domain/usecase/cookbook/add_cookbook_usecase.dart';
import 'package:dio/dio.dart';

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
  Future<Cookbook> addCookbook(AddCookbookParams params) async {
    try {
      var cookbook = new Cookbook(
        creatorPersonId: params.creatorPersonId,
        title: params.title,
        imagePath: params.imagePath,
      );

      var coverFile = File(cookbook.imagePath!);

      // Create a FormData object
      var formData = FormData.fromMap({
        'creatorPersonId': cookbook.creatorPersonId,
        'title': cookbook.title,
        'cover': await MultipartFile.fromFile(coverFile.path,
            filename: coverFile.path.split('/').last),
      });

      final res = await _dioClient.dio.post(
        Endpoints.addCookbook,
        data: formData,
      );

      var newCookbook = Cookbook.fromMap(res.data);
      return newCookbook;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
