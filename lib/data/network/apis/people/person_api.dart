import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/person/person.dart';
import 'package:boilerplate/domain/usecase/person/login_usecase.dart';
import 'package:boilerplate/domain/usecase/person/register_usecase.dart';
import 'package:boilerplate/domain/usecase/person/update_person_usecase.dart';

class PersonApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  PersonApi(this._dioClient);

  // TODO update endpoint to use auth token; throw not found exception if
  // person not found by email
  Future<Person> login(LoginParams loginParams) async {
    try {
      final res = await _dioClient.dio.post(
        Endpoints.postLogin,
        data: loginParams.toJson(),
      );

      final person = await findPersonByEmail(loginParams.email);

      return person!;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Person> register(RegisterParams params) async {
    try {
      var person = new Person(
        email: params.email,
        password: params.password,
      );
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

  // TODO add endoint to go out to AddPersonImage endpoint,
  // use below method to upload and call as soon as img selected
  // Future<FormData> toFormData() async {
  //   MultipartFile? imageData;
  //   if (imagePath?.isNotEmpty ?? false) {
  //     final compressedImage = await ImageUtils.getCompressedImage(imagePath!);
  //     imageData = await MultipartFile.fromFile(
  //       compressedImage.path,
  //       filename: compressedImage.path.split('/').last,
  //     );
  //   }

  Future<Person> patch(UpdatePersonParams params) async {
    try {
      var patchDocument = await _buildPatchDocument(
        params.displayName,
        params.imagePath,
        params.password,
      );

      final res = await _dioClient.dio.patch(
        Endpoints.patchPerson(params.personId),
        data: patchDocument,
      );

      return Person.fromMap(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  List<Map<String, dynamic>> _buildPatchDocument(
    String? displayName,
    String? imagePath,
    String? password,
  ) {
    var patchDocument = <Map<String, dynamic>>[];

    if (displayName != null && displayName.trim().isNotEmpty) {
      patchDocument.add({
        "op": "replace",
        "path": "/displayName",
        "value": displayName,
      });
    }

    if (imagePath != null && imagePath.trim().isNotEmpty) {
      patchDocument.add({
        "op": "replace",
        "path": "/imagePath",
        "value": imagePath,
      });
    }

    if (password != null && password.trim().isNotEmpty) {
      patchDocument.add({
        "op": "replace",
        "path": "/password",
        "value": password,
      });
    }

    return patchDocument;
  }
}
