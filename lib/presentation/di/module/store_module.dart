import 'dart:async';
import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/domain/repository/setting/setting_repository.dart';
import 'package:boilerplate/domain/usecase/cookbook/get_cookbook_usecase.dart';
import 'package:boilerplate/domain/usecase/cookbook/add_cookbook_usecase.dart';
import 'package:boilerplate/domain/usecase/person/find_person_by_email_usecase.dart';
import 'package:boilerplate/domain/usecase/person/find_person_by_id_usecase.dart';
import 'package:boilerplate/domain/usecase/person/get_person_id_usecase.dart';
import 'package:boilerplate/domain/usecase/person/login_usecase.dart';
import 'package:boilerplate/domain/usecase/person/register_usecase.dart';
import 'package:boilerplate/domain/usecase/person/save_person_id_usecase.dart';
import 'package:boilerplate/domain/usecase/person/update_person_usecase.dart';
import 'package:boilerplate/domain/usecase/recipe/add_recipe_usecase.dart';
import 'package:boilerplate/domain/usecase/recipe/find_recipe_by_id_usecase.dart';
import 'package:boilerplate/domain/usecase/recipe/get_recipe_usecase.dart';
import 'package:boilerplate/presentation/cookbook/store/cookbook_store.dart';
import 'package:boilerplate/presentation/home/store/language/language_store.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/person_store.dart';
import 'package:boilerplate/presentation/recipe/store/recipe_store.dart';
import '../../../di/service_locator.dart';

mixin StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(() => CookbookErrorStore());
    getIt.registerFactory(() => RecipeErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------
    getIt.registerSingleton<PersonStore>(
      PersonStore(
        getIt<GetPersonIdUseCase>(),
        getIt<SavePersonIdUseCase>(),
        getIt<LoginUseCase>(),
        getIt<RegisterUseCase>(),
        getIt<FindPersonByEmailUseCase>(),
        getIt<FindPersonByIdUseCase>(),
        getIt<UpdatePersonUseCase>(),
        getIt<FormErrorStore>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<CookbookStore>(
      CookbookStore(
        getIt<GetCookbookUseCase>(),
        getIt<AddCookbookUseCase>(),
        getIt<ErrorStore>(),
        getIt<CookbookErrorStore>(),
      ),
    );

    getIt.registerSingleton<RecipeStore>(
      RecipeStore(
        getIt<GetRecipeUseCase>(),
        getIt<AddRecipeUseCase>(),
        getIt<FindRecipeByIdUseCase>(),
        getIt<ErrorStore>(),
        getIt<RecipeErrorStore>(),
      ),
    );

    getIt.registerSingleton<ThemeStore>(
      ThemeStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<LanguageStore>(
      LanguageStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );
  }
}
