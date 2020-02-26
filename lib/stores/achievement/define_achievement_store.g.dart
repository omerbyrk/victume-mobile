// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'define_achievement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DefineAchievementStore on _DefineAchievementStore, Store {
  final _$achievementIdAtom =
      Atom(name: '_DefineAchievementStore.achievementId');

  @override
  String get achievementId {
    _$achievementIdAtom.context.enforceReadPolicy(_$achievementIdAtom);
    _$achievementIdAtom.reportObserved();
    return super.achievementId;
  }

  @override
  set achievementId(String value) {
    _$achievementIdAtom.context.conditionallyRunInAction(() {
      super.achievementId = value;
      _$achievementIdAtom.reportChanged();
    }, _$achievementIdAtom, name: '${_$achievementIdAtom.name}_set');
  }

  final _$saveOrUpdateAchievementAsyncAction =
      AsyncAction('saveOrUpdateAchievement');

  @override
  Future saveOrUpdateAchievement(AchievementDTO achievementDTO) {
    return _$saveOrUpdateAchievementAsyncAction
        .run(() => super.saveOrUpdateAchievement(achievementDTO));
  }

  final _$closeLoadingAsyncAction = AsyncAction('closeLoading');

  @override
  Future closeLoading() {
    return _$closeLoadingAsyncAction.run(() => super.closeLoading());
  }
}

mixin _$DefineAchievementFormStore on _DefineAchievementFormStore, Store {
  Computed<String> _$parameterIdValidateTextComputed;

  @override
  String get parameterIdValidateText => (_$parameterIdValidateTextComputed ??=
          Computed<String>(() => super.parameterIdValidateText))
      .value;
  Computed<String> _$targetValueValidateTextComputed;

  @override
  String get targetValueValidateText => (_$targetValueValidateTextComputed ??=
          Computed<String>(() => super.targetValueValidateText))
      .value;
  Computed<String> _$targetDateValidateTextComputed;

  @override
  String get targetDateValidateText => (_$targetDateValidateTextComputed ??=
          Computed<String>(() => super.targetDateValidateText))
      .value;

  final _$parameterIdAtom =
      Atom(name: '_DefineAchievementFormStore.parameterId');

  @override
  String get parameterId {
    _$parameterIdAtom.context.enforceReadPolicy(_$parameterIdAtom);
    _$parameterIdAtom.reportObserved();
    return super.parameterId;
  }

  @override
  set parameterId(String value) {
    _$parameterIdAtom.context.conditionallyRunInAction(() {
      super.parameterId = value;
      _$parameterIdAtom.reportChanged();
    }, _$parameterIdAtom, name: '${_$parameterIdAtom.name}_set');
  }

  final _$targetValueAtom =
      Atom(name: '_DefineAchievementFormStore.targetValue');

  @override
  String get targetValue {
    _$targetValueAtom.context.enforceReadPolicy(_$targetValueAtom);
    _$targetValueAtom.reportObserved();
    return super.targetValue;
  }

  @override
  set targetValue(String value) {
    _$targetValueAtom.context.conditionallyRunInAction(() {
      super.targetValue = value;
      _$targetValueAtom.reportChanged();
    }, _$targetValueAtom, name: '${_$targetValueAtom.name}_set');
  }

  final _$targetDateAtom = Atom(name: '_DefineAchievementFormStore.targetDate');

  @override
  DateTime get targetDate {
    _$targetDateAtom.context.enforceReadPolicy(_$targetDateAtom);
    _$targetDateAtom.reportObserved();
    return super.targetDate;
  }

  @override
  set targetDate(DateTime value) {
    _$targetDateAtom.context.conditionallyRunInAction(() {
      super.targetDate = value;
      _$targetDateAtom.reportChanged();
    }, _$targetDateAtom, name: '${_$targetDateAtom.name}_set');
  }

  final _$_DefineAchievementFormStoreActionController =
      ActionController(name: '_DefineAchievementFormStore');

  @override
  void setParameterId(String newValue) {
    final _$actionInfo =
        _$_DefineAchievementFormStoreActionController.startAction();
    try {
      return super.setParameterId(newValue);
    } finally {
      _$_DefineAchievementFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTargetValue(String newValue) {
    final _$actionInfo =
        _$_DefineAchievementFormStoreActionController.startAction();
    try {
      return super.setTargetValue(newValue);
    } finally {
      _$_DefineAchievementFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTargetDate(DateTime newValue) {
    final _$actionInfo =
        _$_DefineAchievementFormStoreActionController.startAction();
    try {
      return super.setTargetDate(newValue);
    } finally {
      _$_DefineAchievementFormStoreActionController.endAction(_$actionInfo);
    }
  }
}
