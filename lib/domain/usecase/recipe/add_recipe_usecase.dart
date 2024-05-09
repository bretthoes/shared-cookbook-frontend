import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/recipe/recipe.dart';
import 'package:boilerplate/domain/repository/recipe/recipe_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_recipe_usecase.g.dart';

@JsonSerializable()
class AddRecipeParams {
  final int creatorPersonId;
  final String title;
  final String imagePath;

  AddRecipeParams(
      {required this.creatorPersonId,
      required this.title,
      required this.imagePath});

  factory AddRecipeParams.fromJson(Map<String, dynamic> json) =>
      _$AddRecipeParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddRecipeParamsToJson(this);
}

class AddRecipeUseCase extends UseCase<Recipe?, AddRecipeParams> {
  final RecipeRepository _recipeRepository;

  AddRecipeUseCase(this._recipeRepository);

  @override
  Future<Recipe?> call({required params}) {
    return _recipeRepository.add(params);
  }
}
