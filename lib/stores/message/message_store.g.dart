// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessageStore on _MessageStore, Store {
  final _$messageListAtom = Atom(name: '_MessageStore.messageList');

  @override
  ObservableList<Message> get messageList {
    _$messageListAtom.context.enforceReadPolicy(_$messageListAtom);
    _$messageListAtom.reportObserved();
    return super.messageList;
  }

  @override
  set messageList(ObservableList<Message> value) {
    _$messageListAtom.context.conditionallyRunInAction(() {
      super.messageList = value;
      _$messageListAtom.reportChanged();
    }, _$messageListAtom, name: '${_$messageListAtom.name}_set');
  }

  final _$_MessageStoreActionController =
      ActionController(name: '_MessageStore');

  @override
  dynamic send(Message message) {
    final _$actionInfo = _$_MessageStoreActionController.startAction();
    try {
      return super.send(message);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }
}
