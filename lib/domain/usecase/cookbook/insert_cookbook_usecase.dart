import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/repository/cookbook/cookbook_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'insert_cookbook_usecase.g.dart';

@JsonSerializable()
class InsertCookbookParams {
  final int creatorPersonId;
  final String title;
  final String imagePath;

  InsertCookbookParams(
      {required this.creatorPersonId,
      required this.title,
      required this.imagePath});

  factory InsertCookbookParams.fromJson(Map<String, dynamic> json) =>
      _$InsertCookbookParamsFromJson(json);

  Map<String, dynamic> toJson() => _$InsertCookbookParamsToJson(this);
}

class InsertCookbookUseCase extends UseCase<Cookbook?, InsertCookbookParams> {
  final CookbookRepository _cookbookRepository;

  InsertCookbookUseCase(this._cookbookRepository);

  @override
  Future<Cookbook?> call({required params}) {
    return _cookbookRepository.insert(params);
  }
}
