import 'dart:async';
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook_list.dart';
import 'package:boilerplate/domain/usecase/cookbook/add_cookbook_usecase.dart';
import 'package:boilerplate/utils/image_utils.dart';
import 'package:dio/dio.dart';

class CookbookApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  CookbookApi(this._dioClient);

  Future<CookbookList> getCookbooks(int personId) async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getCookbooks(personId));
      return CookbookList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Cookbook> addCookbook(AddCookbookParams params) async {
    try {
      var compressedImage =
          await ImageUtils.getCompressedImage(params.imagePath);

      // create a FormData object to post image file
      var formData = FormData.fromMap({
        'creatorPersonId': params.creatorPersonId,
        'title': params.title,
        'cover': await MultipartFile.fromFile(compressedImage.path,
            filename: compressedImage.path.split('/').last),
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
