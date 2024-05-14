import 'dart:async';

import 'package:boilerplate/data/local/datasources/cookbook/cookbook_datasource.dart';
import 'package:boilerplate/data/local/datasources/person/person_datasource.dart';
import 'package:boilerplate/data/local/datasources/post/post_datasource.dart';
import 'package:boilerplate/data/local/datasources/recipe/recipe_datasource.dart';
import 'package:boilerplate/data/network/apis/cookbooks/cookbook_api.dart';
import 'package:boilerplate/data/network/apis/people/person_api.dart';
import 'package:boilerplate/data/network/apis/posts/post_api.dart';
import 'package:boilerplate/data/network/apis/recipes/recipe_api.dart';
import 'package:boilerplate/data/repository/cookbook/cookbook_repository_impl.dart';
import 'package:boilerplate/data/repository/post/post_repository_impl.dart';
import 'package:boilerplate/data/repository/recipe/recipe_repository_impl.dart';
import 'package:boilerplate/data/repository/setting/setting_repository_impl.dart';
import 'package:boilerplate/data/repository/user/person_repository_impl.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/cookbook/cookbook_repository.dart';
import 'package:boilerplate/domain/repository/post/post_repository.dart';
import 'package:boilerplate/domain/repository/recipe/recipe_repository.dart';
import 'package:boilerplate/domain/repository/setting/setting_repository.dart';
import 'package:boilerplate/domain/repository/person/person_repository.dart';

import '../../../di/service_locator.dart';

mixin RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<PersonRepository>(PersonRepositoryImpl(
      getIt<PersonApi>(),
      getIt<SharedPreferenceHelper>(),
      getIt<PersonDataSource>(),
    ));

    getIt.registerSingleton<PostRepository>(PostRepositoryImpl(
      getIt<PostApi>(),
      getIt<PostDataSource>(),
    ));

    getIt.registerSingleton<CookbookRepository>(CookbookRepositoryImpl(
      getIt<CookbookApi>(),
      getIt<CookbookDataSource>(),
    ));

    getIt.registerSingleton<RecipeRepository>(RecipeRepositoryImpl(
      getIt<RecipeApi>(),
      getIt<RecipeDataSource>(),
    ));
  }
}
