import 'package:mobx/mobx.dart';

part 'error_store.g.dart';

class ErrorStore = _ErrorStore with _$ErrorStore;

abstract class _ErrorStore with Store {
  // disposers
  late List<ReactionDisposer> _disposers;

  // constructor:---------------------------------------------------------------
  _ErrorStore() {
    _disposers = [
      reaction((_) => errorMessage, reset, delay: 200),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String errorMessage = '';

  @observable
  int errorCode = 0;

  // actions:-------------------------------------------------------------------
  @action
  void setErrorMessage(String message) {
    this.errorMessage = message;
  }

  @action
  void setErrorCode(int code) {
    this.errorCode = code;
  }

  @action
  void reset(String value) {
    setErrorMessage('');
    setErrorCode(0);
  }

  // dispose:-------------------------------------------------------------------
  @action
  dispose() {
    for (final disposer in _disposers) {
      disposer();
    }
  }
}
