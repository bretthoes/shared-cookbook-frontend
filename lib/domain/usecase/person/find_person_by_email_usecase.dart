import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/person/person.dart';
import 'package:boilerplate/domain/repository/person/person_repository.dart';

class FindPersonByEmailUseCase extends UseCase<Person?, String> {
  final PersonRepository _personRepository;

  FindPersonByEmailUseCase(this._personRepository);

  @override
  Future<Person?> call({required String params}) {
    return _personRepository.findPersonByEmail(params);
  }
}
