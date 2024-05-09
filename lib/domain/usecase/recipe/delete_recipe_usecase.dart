import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/recipe/recipe.dart';
import 'package:boilerplate/domain/repository/recipe/recipe_repository.dart';

class DeleteRecipeUseCase extends UseCase<int, Recipe> {
  final RecipeRepository _recipeRepository;

  DeleteRecipeUseCase(this._recipeRepository);

  @override
  Future<int> call({required params}) {
    return _recipeRepository.delete(params);
  }
}
