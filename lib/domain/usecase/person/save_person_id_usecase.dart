import '../../../core/domain/usecase/use_case.dart';
import '../../repository/person/person_repository.dart';

class SavePersonIdUseCase implements UseCase<void, int> {
  final PersonRepository _personRepository;

  SavePersonIdUseCase(this._personRepository);

  @override
  Future<bool> call({required int params}) async {
    return _personRepository.savePersonId(params);
  }
}
