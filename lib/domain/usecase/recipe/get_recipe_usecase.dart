import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/recipe/recipe_list.dart';
import 'package:boilerplate/domain/repository/recipe/recipe_repository.dart';

class GetRecipeUseCase extends UseCase<RecipeList, int> {
  final RecipeRepository _recipeRepository;

  GetRecipeUseCase(this._recipeRepository);

  @override
  Future<RecipeList> call({required int params}) {
    return _recipeRepository.getRecipes(params);
  }
}
