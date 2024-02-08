import '../../../core/domain/usecase/use_case.dart';
import '../../repository/person/person_repository.dart';

class SaveLoginStatusUseCase implements UseCase<void, bool> {
  final PersonRepository _personRepository;

  SaveLoginStatusUseCase(this._personRepository);

  @override
  Future<void> call({required bool params}) async {
    return _personRepository.saveIsLoggedIn(params);
  }
}
