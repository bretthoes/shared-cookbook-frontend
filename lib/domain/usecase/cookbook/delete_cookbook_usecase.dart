import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/repository/cookbook/cookbook_repository.dart';

class DeleteCookbookUseCase extends UseCase<int, Cookbook> {
  final CookbookRepository _cookbookRepository;

  DeleteCookbookUseCase(this._cookbookRepository);

  @override
  Future<int> call({required params}) {
    return _cookbookRepository.delete(params);
  }
}
