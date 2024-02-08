import '../../../core/domain/usecase/use_case.dart';
import '../../entity/person/person.dart';
import '../../repository/person/person_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_usecase.g.dart';

@JsonSerializable()
class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});

  factory LoginParams.fromJson(Map<String, dynamic> json) =>
      _$LoginParamsFromJson(json);

  Map<String, dynamic> toJson() => _$LoginParamsToJson(this);
}

class LoginUseCase implements UseCase<Person?, LoginParams> {
  final PersonRepository _personRepository;

  LoginUseCase(this._personRepository);

  @override
  Future<Person?> call({required LoginParams params}) async {
    return _personRepository.login(params);
  }
}
