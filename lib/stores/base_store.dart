import 'package:mobx/mobx.dart';
import 'package:victume_mobile/stores/ui_message/ui_message_store.dart';

part 'base_store.g.dart';

class BaseStore = _BaseStore with _$BaseStore;

abstract class _BaseStore with Store {
  final UIMessageStore uiMessageStore = new UIMessageStore();

  @observable
  bool loading = false;
}
