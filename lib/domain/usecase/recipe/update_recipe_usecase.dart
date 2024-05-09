import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/recipe/recipe.dart';
import 'package:boilerplate/domain/repository/recipe/recipe_repository.dart';

class UpdateRecipeUseCase extends UseCase<int, Recipe> {
  final RecipeRepository _recipeRepository;

  UpdateRecipeUseCase(this._recipeRepository);

  @override
  Future<int> call({required params}) {
    return _recipeRepository.update(params);
  }
}
