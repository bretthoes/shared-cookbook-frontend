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
      formErrorStore.name = "Name can't be empty";
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      formErrorStore.name = 'Name is invalid';
    } else if (value.length < 3 || value.length > 16) {
      formErrorStore.name = 'Name should be 3-16 characters';
    } else {
      formErrorStore.name = null;
    }
  }

  @action
  void validateEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.email = "Email can't be empty";
    } else if (!isEmail(value)) {
      formErrorStore.email = 'Please enter a valid email address';
    } else {
      formErrorStore.email = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "can't be empty";
    } else if (value.length < 6) {
      formErrorStore.password = "at least 6 characters please";
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      formErrorStore.password = "please add a number";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.confirmPassword = "Confirm password can't be empty";
    } else if (value != password) {
      formErrorStore.confirmPassword = "Password doesn't match";
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
