import '../../../core/domain/usecase/use_case.dart';
import '../../repository/person/person_repository.dart';

class IsLoggedInUseCase implements UseCase<bool, void> {
  final PersonRepository _personRepository;

  IsLoggedInUseCase(this._personRepository);

  @override
  Future<bool> call({required void params}) async {
    return await _personRepository.isLoggedIn;
  }
}
