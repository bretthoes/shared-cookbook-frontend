// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_UserStore.isLoading'))
      .value;

  late final _$successAtom = Atom(name: '_UserStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$loginFutureAtom =
      Atom(name: '_UserStore.loginFuture', context: context);

  @override
  ObservableFuture<Person?> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<Person?> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
    });
  }

  late final _$fetchPersonFutureAtom =
      Atom(name: '_UserStore.fetchPersonFuture', context: context);

  @override
  ObservableFuture<Person?> get fetchPersonFuture {
    _$fetchPersonFutureAtom.reportRead();
    return super.fetchPersonFuture;
  }

  @override
  set fetchPersonFuture(ObservableFuture<Person?> value) {
    _$fetchPersonFutureAtom.reportWrite(value, super.fetchPersonFuture, () {
      super.fetchPersonFuture = value;
    });
  }

  late final _$personAtom = Atom(name: '_UserStore.person', context: context);

  @override
  Person? get person {
    _$personAtom.reportRead();
    return super.person;
  }

  bool _personIsInitialized = false;

  @override
  set person(Person? value) {
    _$personAtom.reportWrite(value, _personIsInitialized ? super.person : null,
        () {
      super.person = value;
      _personIsInitialized = true;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_UserStore.login', context: context);

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  late final _$registerAsyncAction =
      AsyncAction('_UserStore.register', context: context);

  @override
  Future<dynamic> register(String email, String password) {
    return _$registerAsyncAction.run(() => super.register(email, password));
  }

  late final _$getPersonByEmailAsyncAction =
      AsyncAction('_UserStore.getPersonByEmail', context: context);

  @override
  Future<dynamic> getPersonByEmail(String email) {
    return _$getPersonByEmailAsyncAction
        .run(() => super.getPersonByEmail(email));
  }

  late final _$updatePersonAsyncAction =
      AsyncAction('_UserStore.updatePerson', context: context);

  @override
  Future<dynamic> updatePerson(
      int personId, String? displayName, String? imagePath, String? password) {
    return _$updatePersonAsyncAction.run(
        () => super.updatePerson(personId, displayName, imagePath, password));
  }

  @override
  String toString() {
    return '''
success: ${success},
loginFuture: ${loginFuture},
fetchPersonFuture: ${fetchPersonFuture},
person: ${person},
isLoading: ${isLoading}
    ''';
  }
}
