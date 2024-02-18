// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ProfileStore.loading'))
      .value;

  late final _$fetchPersonFutureAtom =
      Atom(name: '_ProfileStore.fetchPersonFuture', context: context);

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

  late final _$personAtom =
      Atom(name: '_ProfileStore.person', context: context);

  @override
  Person? get person {
    _$personAtom.reportRead();
    return super.person;
  }

  @override
  set person(Person? value) {
    _$personAtom.reportWrite(value, super.person, () {
      super.person = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_ProfileStore.success', context: context);

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

  late final _$getPersonAsyncAction =
      AsyncAction('_ProfileStore.getPerson', context: context);

  @override
  Future<dynamic> getPerson(int personId) {
    return _$getPersonAsyncAction.run(() => super.getPerson(personId));
  }

  @override
  String toString() {
    return '''
fetchPersonFuture: ${fetchPersonFuture},
person: ${person},
success: ${success},
loading: ${loading}
    ''';
  }
}
