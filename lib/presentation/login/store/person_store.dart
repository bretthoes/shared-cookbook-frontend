import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/domain/usecase/person/find_person_by_email_usecase.dart';
import 'package:boilerplate/domain/usecase/person/is_logged_in_usecase.dart';
import 'package:boilerplate/domain/usecase/person/register_usecase.dart';
import 'package:boilerplate/domain/usecase/person/save_login_in_status_usecase.dart';
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
    this._isLoggedInUseCase,
    this._saveLoginStatusUseCase,
    this._loginUseCase,
    this._registerUseCase,
    this._findPersonByEmailUseCase,
    this._updatePersonUseCase,
    this.formErrorStore,
    this.errorStore,
  ) {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    _isLoggedInUseCase.call(params: null).then((value) async {
      isLoggedIn = value;
    });
  }

  // use cases:-----------------------------------------------------------------
  final IsLoggedInUseCase _isLoggedInUseCase;
  final SaveLoginStatusUseCase _saveLoginStatusUseCase;
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final FindPersonByEmailUseCase _findPersonByEmailUseCase;
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
  bool isLoggedIn = false;

  @observable
  bool success = false;

  @observable
  ObservableFuture<Person?> loginFuture = emptyLoginResponse;

  @observable
  ObservableFuture<Person?> fetchPersonFuture = ObservableFuture.value(null);

  @observable
  Person? person;

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
        await _saveLoginStatusUseCase.call(params: true);
        this.isLoggedIn = true;
        this.success = true;
        this.person = value;
      }
    }).catchError((error) {
      print(error);
      this.isLoggedIn = false;
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
        await _saveLoginStatusUseCase.call(params: true);
        this.isLoggedIn = true;
        this.success = true;
        this.person = value;
      }
    }).catchError((error) {
      print(error);
      this.isLoggedIn = false;
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
    this.isLoggedIn = false;
    await _saveLoginStatusUseCase.call(params: false);
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
