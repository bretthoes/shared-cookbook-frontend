// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookbook_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CookbookStore on _CookbookStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_CookbookStore.loading'))
      .value;

  late final _$fetchCookbooksFutureAtom =
      Atom(name: '_CookbookStore.fetchCookbooksFuture', context: context);

  @override
  ObservableFuture<CookbookList?> get fetchCookbooksFuture {
    _$fetchCookbooksFutureAtom.reportRead();
    return super.fetchCookbooksFuture;
  }

  @override
  set fetchCookbooksFuture(ObservableFuture<CookbookList?> value) {
    _$fetchCookbooksFutureAtom.reportWrite(value, super.fetchCookbooksFuture,
        () {
      super.fetchCookbooksFuture = value;
    });
  }

  late final _$cookbookListAtom =
      Atom(name: '_CookbookStore.cookbookList', context: context);

  @override
  CookbookList? get cookbookList {
    _$cookbookListAtom.reportRead();
    return super.cookbookList;
  }

  @override
  set cookbookList(CookbookList? value) {
    _$cookbookListAtom.reportWrite(value, super.cookbookList, () {
      super.cookbookList = value;
    });
  }

  late final _$newTitleAtom =
      Atom(name: '_CookbookStore.newTitle', context: context);

  @override
  String? get newTitle {
    _$newTitleAtom.reportRead();
    return super.newTitle;
  }

  @override
  set newTitle(String? value) {
    _$newTitleAtom.reportWrite(value, super.newTitle, () {
      super.newTitle = value;
    });
  }

  late final _$newCoverAtom =
      Atom(name: '_CookbookStore.newCover', context: context);

  @override
  String? get newCover {
    _$newCoverAtom.reportRead();
    return super.newCover;
  }

  @override
  set newCover(String? value) {
    _$newCoverAtom.reportWrite(value, super.newCover, () {
      super.newCover = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_CookbookStore.success', context: context);

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

  late final _$getCookbooksAsyncAction =
      AsyncAction('_CookbookStore.getCookbooks', context: context);

  @override
  Future<dynamic> getCookbooks(int personId) {
    return _$getCookbooksAsyncAction.run(() => super.getCookbooks(personId));
  }

  late final _$addCookbookAsyncAction =
      AsyncAction('_CookbookStore.addCookbook', context: context);

  @override
  Future<dynamic> addCookbook(int creatorPersonId, String title, String cover) {
    return _$addCookbookAsyncAction
        .run(() => super.addCookbook(creatorPersonId, title, cover));
  }

  late final _$_CookbookStoreActionController =
      ActionController(name: '_CookbookStore', context: context);

  @override
  void validateAddCookbook() {
    final _$actionInfo = _$_CookbookStoreActionController.startAction(
        name: '_CookbookStore.validateAddCookbook');
    try {
      return super.validateAddCookbook();
    } finally {
      _$_CookbookStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitle(String value) {
    final _$actionInfo = _$_CookbookStoreActionController.startAction(
        name: '_CookbookStore.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_CookbookStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchCookbooksFuture: ${fetchCookbooksFuture},
cookbookList: ${cookbookList},
newTitle: ${newTitle},
newCover: ${newCover},
success: ${success},
loading: ${loading}
    ''';
  }
}
