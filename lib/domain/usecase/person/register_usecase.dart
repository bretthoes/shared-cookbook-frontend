import '../../../core/domain/usecase/use_case.dart';
import '../../entity/person/person.dart';
import '../../repository/person/person_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_usecase.g.dart';

@JsonSerializable()
class RegisterParams {
  final String email;
  final String password;

  RegisterParams({required this.email, required this.password});

  factory RegisterParams.fromJson(Map<String, dynamic> json) =>
      _$RegisterParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterParamsToJson(this);
}

class RegisterUseCase implements UseCase<Person?, RegisterParams> {
  final PersonRepository _personRepository;

  RegisterUseCase(this._personRepository);

  @override
  Future<Person?> call({required RegisterParams params}) async {
    return _personRepository.register(params);
  }
}
