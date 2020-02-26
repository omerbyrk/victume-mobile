import 'package:mobx/mobx.dart';

part 'ui_message_store.g.dart';

enum MESSAGE_TYPE { ERROR, INFO, SUCCESS, UNSET }

class UIMessageStore = _UIMessageStore with _$UIMessageStore;

abstract class _UIMessageStore with Store {
  // store variables:-----------------------------------------------------------
  @observable
  String message = "";

  @observable
  MESSAGE_TYPE type = MESSAGE_TYPE.UNSET;

  @computed
  bool get showMessage =>
      (message != null && message != "") &&
      (type != null || type == MESSAGE_TYPE.UNSET);

  @action
  setSuccess(String message) {
    this.message = message;
    type = MESSAGE_TYPE.SUCCESS;
  }

  @action
  setError(String message) {
    this.message = message;
    type = MESSAGE_TYPE.ERROR;
  }

  @action
  setInfo(String message) {
    this.message = message;
    type = MESSAGE_TYPE.INFO;
  }

  @action
  clear() {
    this.message = "";
    type = MESSAGE_TYPE.UNSET;
  }
}
