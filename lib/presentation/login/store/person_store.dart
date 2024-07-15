import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/domain/usecase/person/find_person_by_email_usecase.dart';
import 'package:boilerplate/domain/usecase/person/find_person_by_id_usecase.dart';
import 'package:boilerplate/domain/usecase/person/get_person_id_usecase.dart';
import 'package:boilerplate/domain/usecase/person/register_usecase.dart';
import 'package:boilerplate/domain/usecase/person/save_person_id_usecase.dart';
import 'package:boilerplate/domain/usecase/person/update_person_usecase.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import '../../../domain/entity/person/person.dart';
import '../../../domain/usecase/person/login_usecase.dart';

part 'person_store.g.dart';

class PersonStore = _PersonStore with _$PersonStore;

abstract class _PersonStore with Store {
  // constructor:---------------------------------------------------------------
  _PersonStore(
    this._getPersonIdUseCase,
    this._savePersonIdUseCase,
    this._loginUseCase,
    this._registerUseCase,
    this._findPersonByEmailUseCase,
    this._findPersonByIdUseCase,
    this._updatePersonUseCase,
    this.formErrorStore,
    this.errorStore,
  ) {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    _getPersonIdUseCase.call(params: null).then((value) async {
      personId = value;
    });
  }

  // use cases:-----------------------------------------------------------------
  final GetPersonIdUseCase _getPersonIdUseCase;
  final SavePersonIdUseCase _savePersonIdUseCase;
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final FindPersonByEmailUseCase _findPersonByEmailUseCase;
  final FindPersonByIdUseCase _findPersonByIdUseCase;
  final UpdatePersonUseCase _updatePersonUseCase;

  // stores:--------------------------------------------------------------------
  // for handling form errors
  final FormErrorStore formErrorStore;

  // store for handling error messages
  final ErrorStore errorStore;

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<Person?> emptyLoginResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  int personId = 0;

  @observable
  bool success = false;

  @observable
  ObservableFuture<Person?> loginFuture = emptyLoginResponse;

  @observable
  ObservableFuture<Person?> fetchPersonFuture = ObservableFuture.value(null);

  @observable
  Person? person;

  @observable
  String newProfileImage = '';

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future login(String email, String password) async {
    final LoginParams loginParams =
        LoginParams(email: email, password: password);
    final future = _loginUseCase.call(params: loginParams);
    loginFuture = ObservableFuture(future);

    await future.then((value) async {
      if (value != null) {
        await _handleLogin(value);
      }
    }).catchError((error) {
      print(error);
      this.success = false;
      errorStore.setErrorMessage(DioErrorUtil.handleError(error));
      errorStore.setErrorCode(error.response?.statusCode);
    });
  }

  @action
  Future register(String email, String password) async {
    final RegisterParams registerParams =
        RegisterParams(email: email, password: password);
    final future = _registerUseCase.call(params: registerParams);
    loginFuture = ObservableFuture(future);

    await future.then((value) async {
      if (value != null) {
        await _handleLogin(value);
      }
    }).catchError((error) {
      print(error);
      this.success = false;
      errorStore.setErrorMessage(DioErrorUtil.handleError(error));
      errorStore.setErrorCode(error.response?.statusCode);
    });
  }

  @action
  Future getPersonByEmail(String email) async {
    final future = _findPersonByEmailUseCase.call(params: email);
    fetchPersonFuture = ObservableFuture(future);

    await future.then((person) async {
      this.person = person;
    }).catchError((error) {
      errorStore.setErrorMessage(DioErrorUtil.handleError(error));
      errorStore.setErrorCode(error.response?.statusCode);
    });
  }

  @action
  Future getPersonById(int personId) async {
    final future = _findPersonByIdUseCase.call(params: personId);
    fetchPersonFuture = ObservableFuture(future);

    await future.then((person) async {
      this.person = person;
    }).catchError((error) {
      errorStore.setErrorMessage(DioErrorUtil.handleError(error));
      errorStore.setErrorCode(error.response?.statusCode);
    });
  }

  @action
  Future updatePerson(
    int personId,
    String? displayName,
    String? imagePath,
    String? password,
  ) async {
    var params = UpdatePersonParams(
      personId: personId,
      displayName: displayName,
      imagePath: imagePath,
      password: password,
    );
    final future = _updatePersonUseCase.call(params: params);
    fetchPersonFuture = ObservableFuture(future);

    await future.then((value) async {
      if (value != null) {
        this.person = value;
      }
    }).catchError((e) {
      print(e);
      throw e;
    });
  }

  logout() async {
    this.success = false;
    this.person = null;
    this.personId = 0;
    await _savePersonIdUseCase.call(params: 0);
  }

  _handleLogin(Person person) async {
    this.success = true;
    this.person = person;
    this.personId = person.personId ?? 0;
    await _savePersonIdUseCase.call(params: this.personId);
  }

  @action
  void setNewProfileImage(String value) {
    newProfileImage = value;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
