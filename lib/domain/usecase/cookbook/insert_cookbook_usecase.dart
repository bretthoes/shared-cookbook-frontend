import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/repository/cookbook/cookbook_repository.dart';

class InsertCookbookUseCase extends UseCase<int, Cookbook> {
  final CookbookRepository _cookbookRepository;

  InsertCookbookUseCase(this._cookbookRepository);

  @override
  Future<int> call({required params}) {
    return _cookbookRepository.insert(params);
  }
}
