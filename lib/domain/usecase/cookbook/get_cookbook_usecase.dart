import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook_list.dart';
import 'package:boilerplate/domain/repository/cookbook/cookbook_repository.dart';

class GetCookbookUseCase extends UseCase<CookbookList, int> {
  final CookbookRepository _cookbookRepository;

  GetCookbookUseCase(this._cookbookRepository);

  @override
  Future<CookbookList> call({required int params}) {
    return _cookbookRepository.getCookbooks(params);
  }
}
