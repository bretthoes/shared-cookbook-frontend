import '../../../core/domain/usecase/use_case.dart';
import '../../repository/person/person_repository.dart';

class GetPersonIdUseCase implements UseCase<int, void> {
  final PersonRepository _personRepository;

  GetPersonIdUseCase(this._personRepository);

  @override
  Future<int> call({required void params}) async {
    return await _personRepository.personId;
  }
}
