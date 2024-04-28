import 'package:boilerplate/core/extensions/string_extension.dart';
import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
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
  );

  // use cases:-----------------------------------------------------------------
  final GetCookbookUseCase _getCookbookUseCase;
  final AddCookbookUseCase _addCookbookUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<CookbookList?> emptyCookbookResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<CookbookList?> fetchCookbooksFuture =
      ObservableFuture<CookbookList?>(emptyCookbookResponse);

  @observable
  CookbookList? cookbookList;

  @observable
  String? newTitle;

  @observable
  String? newCover;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchCookbooksFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getCookbooks(int personId) async {
    final future = _getCookbookUseCase.call(params: personId);
    fetchCookbooksFuture = ObservableFuture(future);

    future.then((cookbookList) {
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
    final addCookbookParams = AddCookbookParams(
        creatorPersonId: creatorPersonId, title: title, imagePath: cover);
    final future = _addCookbookUseCase.call(params: addCookbookParams);

    future.then((addedCookbook) {
      this.cookbookList?.cookbooks.add(addedCookbook!);
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  void validateAddCookbook() {
    errorStore.errorMessage = "";
    if (newTitle.isNullOrWhitespace) {
      errorStore.errorMessage = "please add a title";
      return;
    }
    if (newCover.isNullOrWhitespace) {
      errorStore.errorMessage = "please add a cover image";
      return;
    }
    if (newTitle!.length < 2 || newTitle!.length > 18) {
      errorStore.errorMessage = "must be 2-18 chars";
      return;
    }
  }

  @action
  void setTitle(String value) {
    newTitle = value;
  }
}
