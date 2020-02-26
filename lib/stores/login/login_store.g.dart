// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  Computed<bool> _$canLoginComputed;

  @override
  bool get canLogin =>
      (_$canLoginComputed ??= Computed<bool>(() => super.canLogin)).value;

  final _$userEmailAtom = Atom(name: '_LoginStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.context.enforceReadPolicy(_$userEmailAtom);
    _$userEmailAtom.reportObserved();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.context.conditionallyRunInAction(() {
      super.userEmail = value;
      _$userEmailAtom.reportChanged();
    }, _$userEmailAtom, name: '${_$userEmailAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_LoginStore.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$isLoggedInAtom = Atom(name: '_LoginStore.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.context.enforceReadPolicy(_$isLoggedInAtom);
    _$isLoggedInAtom.reportObserved();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.context.conditionallyRunInAction(() {
      super.isLoggedIn = value;
      _$isLoggedInAtom.reportChanged();
    }, _$isLoggedInAtom, name: '${_$isLoggedInAtom.name}_set');
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  void validateUserEmail(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction();
    try {
      return super.validateUserEmail(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction();
    try {
      return super.validatePassword(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserEmail(String userEmail) {
    final _$actionInfo = _$_LoginStoreActionController.startAction();
    try {
      return super.setUserEmail(userEmail);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String password) {
    final _$actionInfo = _$_LoginStoreActionController.startAction();
    try {
      return super.setPassword(password);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }
}

mixin _$LoginErrorStore on _LoginErrorStore, Store {
  Computed<bool> _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??=
          Computed<bool>(() => super.hasErrorsInLogin))
      .value;

  final _$userEmailAtom = Atom(name: '_LoginErrorStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.context.enforceReadPolicy(_$userEmailAtom);
    _$userEmailAtom.reportObserved();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.context.conditionallyRunInAction(() {
      super.userEmail = value;
      _$userEmailAtom.reportChanged();
    }, _$userEmailAtom, name: '${_$userEmailAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_LoginErrorStore.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }
}
