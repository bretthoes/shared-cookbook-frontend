import 'dart:async';

import 'package:boilerplate/domain/repository/cookbook/cookbook_repository.dart';
import 'package:boilerplate/domain/repository/person/person_repository.dart';
import 'package:boilerplate/domain/repository/recipe/recipe_repository.dart';
import 'package:boilerplate/domain/usecase/cookbook/delete_cookbook_usecase.dart';
import 'package:boilerplate/domain/usecase/cookbook/find_cookbook_by_id_usecase.dart';
import 'package:boilerplate/domain/usecase/cookbook/get_cookbook_usecase.dart';
import 'package:boilerplate/domain/usecase/cookbook/add_cookbook_usecase.dart';
import 'package:boilerplate/domain/usecase/cookbook/update_cookbook_usecase.dart';
import 'package:boilerplate/domain/usecase/person/find_person_by_email_usecase.dart';
import 'package:boilerplate/domain/usecase/person/find_person_by_id_usecase.dart';
import 'package:boilerplate/domain/usecase/person/is_logged_in_usecase.dart';
import 'package:boilerplate/domain/usecase/person/login_usecase.dart';
import 'package:boilerplate/domain/usecase/person/register_usecase.dart';
import 'package:boilerplate/domain/usecase/person/save_login_in_status_usecase.dart';
import 'package:boilerplate/domain/usecase/person/update_person_usecase.dart';
import 'package:boilerplate/domain/usecase/recipe/delete_recipe_usecase.dart';
import 'package:boilerplate/domain/usecase/recipe/find_recipe_by_id_usecase.dart';
import 'package:boilerplate/domain/usecase/recipe/get_recipe_usecase.dart';
import 'package:boilerplate/domain/usecase/recipe/update_recipe_usecase.dart';

import '../../../di/service_locator.dart';
import '../../usecase/recipe/add_recipe_usecase.dart';

mixin UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // person:------------------------------------------------------------------
    getIt.registerSingleton<IsLoggedInUseCase>(
      IsLoggedInUseCase(getIt<PersonRepository>()),
    );
    getIt.registerSingleton<SaveLoginStatusUseCase>(
      SaveLoginStatusUseCase(getIt<PersonRepository>()),
    );
    getIt.registerSingleton<LoginUseCase>(
      LoginUseCase(getIt<PersonRepository>()),
    );
    getIt.registerSingleton<RegisterUseCase>(
      RegisterUseCase(getIt<PersonRepository>()),
    );
    getIt.registerSingleton<FindPersonByIdUseCase>(
      FindPersonByIdUseCase(getIt<PersonRepository>()),
    );
    getIt.registerSingleton<FindPersonByEmailUseCase>(
      FindPersonByEmailUseCase(getIt<PersonRepository>()),
    );
    getIt.registerSingleton<UpdatePersonUseCase>(
      UpdatePersonUseCase(getIt<PersonRepository>()),
    );

    // cookbook:----------------------------------------------------------------
    getIt.registerSingleton<GetCookbookUseCase>(
      GetCookbookUseCase(getIt<CookbookRepository>()),
    );
    getIt.registerSingleton<FindCookbookByIdUseCase>(
      FindCookbookByIdUseCase(getIt<CookbookRepository>()),
    );
    getIt.registerSingleton<AddCookbookUseCase>(
      AddCookbookUseCase(getIt<CookbookRepository>()),
    );
    getIt.registerSingleton<UpdateCookbookUseCase>(
      UpdateCookbookUseCase(getIt<CookbookRepository>()),
    );
    getIt.registerSingleton<DeleteCookbookUseCase>(
      DeleteCookbookUseCase(getIt<CookbookRepository>()),
    );

    // recipe:----------------------------------------------------------------
    getIt.registerSingleton<GetRecipeUseCase>(
      GetRecipeUseCase(getIt<RecipeRepository>()),
    );
    getIt.registerSingleton<FindRecipeByIdUseCase>(
      FindRecipeByIdUseCase(getIt<RecipeRepository>()),
    );
    getIt.registerSingleton<AddRecipeUseCase>(
      AddRecipeUseCase(getIt<RecipeRepository>()),
    );
    getIt.registerSingleton<UpdateRecipeUseCase>(
      UpdateRecipeUseCase(getIt<RecipeRepository>()),
    );
    getIt.registerSingleton<DeleteRecipeUseCase>(
      DeleteRecipeUseCase(getIt<RecipeRepository>()),
    );
  }
}
