import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/repository/cookbook/cookbook_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_cookbook_usecase.g.dart';

@JsonSerializable()
class AddCookbookParams {
  final int creatorPersonId;
  final String title;
  final String imagePath;

  AddCookbookParams(
      {required this.creatorPersonId,
      required this.title,
      required this.imagePath});

  factory AddCookbookParams.fromJson(Map<String, dynamic> json) =>
      _$AddCookbookParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddCookbookParamsToJson(this);
}

class AddCookbookUseCase extends UseCase<Cookbook?, AddCookbookParams> {
  final CookbookRepository _cookbookRepository;

  AddCookbookUseCase(this._cookbookRepository);

  @override
  Future<Cookbook?> call({required params}) {
    return _cookbookRepository.add(params);
  }
}
