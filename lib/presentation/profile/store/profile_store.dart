import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/person/person.dart';
import 'package:boilerplate/domain/usecase/person/find_person_by_id_usecase.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  // constructor:---------------------------------------------------------------
  _ProfileStore(this._getPersonUseCase, this.errorStore);

  // use cases:-----------------------------------------------------------------
  final FindPersonByIdUseCase _getPersonUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<Person?> emptyPersonResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Person?> fetchPersonFuture =
      ObservableFuture<Person?>(emptyPersonResponse);

  @observable
  Person? person;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchPersonFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getPerson(int personId) async {
    final future = _getPersonUseCase.call(params: personId);
    fetchPersonFuture = ObservableFuture(future);

    future.then((person) {
      this.person = person;
    }).catchError((error) {
      errorStore.setErrorMessage(DioErrorUtil.handleError(error));
    });
  }
}
