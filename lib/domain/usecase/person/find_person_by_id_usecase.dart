import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/person/person.dart';
import 'package:boilerplate/domain/repository/person/person_repository.dart';

class FindPersonByIdUseCase extends UseCase<Person?, int> {
  final PersonRepository _personRepository;

  FindPersonByIdUseCase(this._personRepository);

  @override
  Future<Person?> call({required int params}) {
    return _personRepository.findPersonById(params);
  }
}
