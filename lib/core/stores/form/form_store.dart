import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore;

  // store for handling error messages
  final ErrorStore errorStore;

  _FormStore(this.formErrorStore, this.errorStore) {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => name, validateName),
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword)
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  bool success = false;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin &&
      email.isNotEmpty &&
      password.isNotEmpty;

  @computed
  bool get emailValid => !email.isEmpty && isEmail(email);

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && email.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setName(String value) {
    name = value;
  }

  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void validateName(String value) {
    if (value.isEmpty) {
      formErrorStore.name = 'name_cant_be_empty';
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      formErrorStore.name = 'name_is_invalid';
    } else if (value.length < 3 || value.length > 16) {
      formErrorStore.name = 'name_should_be_3_16_characters';
    } else {
      formErrorStore.name = null;
    }
  }

  @action
  void validateEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.email = 'email_cant_be_empty';
    } else if (!isEmail(value)) {
      formErrorStore.email = 'email_is_invalid';
    } else {
      formErrorStore.email = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = 'password_is_empty';
    } else if (value.length < 6) {
      formErrorStore.password = 'enter_at_least_6_characters';
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      formErrorStore.password = 'password_needs_a_number';
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.confirmPassword = 'password_is_empty';
    } else if (value != password) {
      formErrorStore.confirmPassword = 'password_doesnt_match';
    } else {
      formErrorStore.confirmPassword = null;
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateEmail(email);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String? name;

  @observable
  String? email;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @computed
  bool get hasErrorsInLogin => email != null || password != null;

  @computed
  bool get hasErrorsInRegister =>
      email != null || password != null || confirmPassword != null;

  @computed
  bool get hasErrorInForgotPassword => email != null;
}
