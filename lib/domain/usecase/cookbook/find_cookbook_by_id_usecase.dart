import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/repository/cookbook/cookbook_repository.dart';

class FindCookbookByIdUseCase extends UseCase<List<Cookbook>, int> {
  final CookbookRepository _cookbookRepository;

  FindCookbookByIdUseCase(this._cookbookRepository);

  @override
  Future<List<Cookbook>> call({required int params}) {
    return _cookbookRepository.findCookbookById(params);
  }
}
