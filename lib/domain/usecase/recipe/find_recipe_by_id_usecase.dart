import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/recipe/recipe.dart';
import 'package:boilerplate/domain/repository/recipe/recipe_repository.dart';

class FindRecipeByIdUseCase extends UseCase<Recipe, int> {
  final RecipeRepository _recipeRepository;

  FindRecipeByIdUseCase(this._recipeRepository);

  @override
  Future<Recipe> call({required int params}) {
    return _recipeRepository.findRecipeById(params);
  }
}
