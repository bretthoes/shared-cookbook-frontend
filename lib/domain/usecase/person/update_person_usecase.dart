import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/person/person.dart';
import 'package:boilerplate/domain/repository/person/person_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_person_usecase.g.dart';

class UpdatePersonUseCase extends UseCase<Person?, UpdatePersonParams> {
  final PersonRepository _personRepository;

  UpdatePersonUseCase(this._personRepository);

  @override
  Future<Person?> call({required UpdatePersonParams params}) {
    return _personRepository.updatePerson(params);
  }
}

@JsonSerializable()
class UpdatePersonParams {
  final int personId;
  final String? displayName;
  final String? imagePath;
  final String? password;

  UpdatePersonParams({
    required this.personId,
    this.displayName,
    this.imagePath,
    this.password,
  });

  factory UpdatePersonParams.fromJson(Map<String, dynamic> json) =>
      _$UpdatePersonParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePersonParamsToJson(this);
}
