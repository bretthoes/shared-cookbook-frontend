import 'package:boilerplate/core/extensions/string_extension.dart';
import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook_list.dart';
import 'package:boilerplate/domain/usecase/cookbook/add_cookbook_usecase.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/usecase/cookbook/get_cookbook_usecase.dart';

part 'cookbook_store.g.dart';

class CookbookStore = _CookbookStore with _$CookbookStore;

abstract class _CookbookStore with Store {
  // constructor:---------------------------------------------------------------
  _CookbookStore(
    this._getCookbookUseCase,
    this._addCookbookUseCase,
    this.errorStore,
    this.cookbookErrorStore,
  );

  // use cases:-----------------------------------------------------------------
  final GetCookbookUseCase _getCookbookUseCase;
  final AddCookbookUseCase _addCookbookUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;
  final CookbookErrorStore cookbookErrorStore;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<CookbookList?> emptyCookbookResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<CookbookList?> fetchCookbooksFuture =
      ObservableFuture<CookbookList?>(emptyCookbookResponse);

  @observable
  CookbookList cookbookList = new CookbookList(cookbooks: new List.empty());

  @observable
  String newCover = '';

  @computed
  bool get loading => fetchCookbooksFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getCookbooks(int personId) async {
    final future = _getCookbookUseCase.call(params: personId);
    fetchCookbooksFuture = ObservableFuture(future);

    await future.then((cookbookList) {
      this.cookbookList = cookbookList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future addCookbook(
    int creatorPersonId,
    String title,
    String cover,
  ) async {
    cookbookErrorStore.error = validateAddCookbook(
      creatorPersonId,
      title,
      cover,
    );
    if (cookbookErrorStore.error.isNotEmpty) {
      return;
    }

    final params = AddCookbookParams(
      creatorPersonId: creatorPersonId,
      title: title,
      imagePath: cover,
    );
    final future = _addCookbookUseCase.call(params: params);

    await future.then((addedCookbook) {
      if (addedCookbook == null) {
        throw Exception("Failed to add cookbook: returned cookbook is null");
      }
      cookbookList.cookbooks.add(addedCookbook);
      getCookbooks(creatorPersonId);
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  String validateAddCookbook(int creatorPersonId, String title, String cover) {
    var error = "";

    if (creatorPersonId <= 0) {
      error = "please sign in first";
      return error;
    }
    if (title.isNullOrWhitespace) {
      error = "please add a title";
      return error;
    }
    if (cover.isNullOrWhitespace) {
      error = "please add a cover image";
      return error;
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(title)) {
      error = "only alphanumeric characters allowed";
      return error;
    }
    if (title.length < 2 || title.length > 18) {
      error = "must be 2-18 chars";
      return error;
    }

    return error;
  }

  @action
  void setCover(String value) {
    newCover = value;
  }
}

class CookbookErrorStore = _CookbookErrorStore with _$CookbookErrorStore;

abstract class _CookbookErrorStore with Store {
  @observable
  String error = '';
}
