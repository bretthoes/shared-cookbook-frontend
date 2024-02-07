import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook_list.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/usecase/cookbook/get_cookbook_usecase.dart';

part 'cookbook_store.g.dart';

class CookbookStore = _CookbookStore with _$CookbookStore;

abstract class _CookbookStore with Store {
  // constructor:---------------------------------------------------------------
  _CookbookStore(this._getCookbookUseCase, this.errorStore);

  // use cases:-----------------------------------------------------------------
  final GetCookbookUseCase _getCookbookUseCase;

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
}
