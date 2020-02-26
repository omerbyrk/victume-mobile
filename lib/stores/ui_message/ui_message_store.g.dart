// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UIMessageStore on _UIMessageStore, Store {
  Computed<bool> _$showMessageComputed;

  @override
  bool get showMessage =>
      (_$showMessageComputed ??= Computed<bool>(() => super.showMessage)).value;

  final _$messageAtom = Atom(name: '_UIMessageStore.message');

  @override
  String get message {
    _$messageAtom.context.enforceReadPolicy(_$messageAtom);
    _$messageAtom.reportObserved();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.context.conditionallyRunInAction(() {
      super.message = value;
      _$messageAtom.reportChanged();
    }, _$messageAtom, name: '${_$messageAtom.name}_set');
  }

  final _$typeAtom = Atom(name: '_UIMessageStore.type');

  @override
  MESSAGE_TYPE get type {
    _$typeAtom.context.enforceReadPolicy(_$typeAtom);
    _$typeAtom.reportObserved();
    return super.type;
  }

  @override
  set type(MESSAGE_TYPE value) {
    _$typeAtom.context.conditionallyRunInAction(() {
      super.type = value;
      _$typeAtom.reportChanged();
    }, _$typeAtom, name: '${_$typeAtom.name}_set');
  }

  final _$_UIMessageStoreActionController =
      ActionController(name: '_UIMessageStore');

  @override
  dynamic setSuccess(String message) {
    final _$actionInfo = _$_UIMessageStoreActionController.startAction();
    try {
      return super.setSuccess(message);
    } finally {
      _$_UIMessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(String message) {
    final _$actionInfo = _$_UIMessageStoreActionController.startAction();
    try {
      return super.setError(message);
    } finally {
      _$_UIMessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setInfo(String message) {
    final _$actionInfo = _$_UIMessageStoreActionController.startAction();
    try {
      return super.setInfo(message);
    } finally {
      _$_UIMessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clear() {
    final _$actionInfo = _$_UIMessageStoreActionController.startAction();
    try {
      return super.clear();
    } finally {
      _$_UIMessageStoreActionController.endAction(_$actionInfo);
    }
  }
}
