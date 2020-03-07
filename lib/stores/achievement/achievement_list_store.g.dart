// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AchievementListStore on _AchievementListStore, Store {
  Computed<bool> _$isReadyAchievementListComputed;

  @override
  bool get isReadyAchievementList => (_$isReadyAchievementListComputed ??=
          Computed<bool>(() => super.isReadyAchievementList))
      .value;

  final _$achievementListAtom =
      Atom(name: '_AchievementListStore.achievementList');

  @override
  ObservableList<AchievementView> get achievementList {
    _$achievementListAtom.context.enforceReadPolicy(_$achievementListAtom);
    _$achievementListAtom.reportObserved();
    return super.achievementList;
  }

  @override
  set achievementList(ObservableList<AchievementView> value) {
    _$achievementListAtom.context.conditionallyRunInAction(() {
      super.achievementList = value;
      _$achievementListAtom.reportChanged();
    }, _$achievementListAtom, name: '${_$achievementListAtom.name}_set');
  }

  final _$showCongratulationsAtom =
      Atom(name: '_AchievementListStore.showCongratulations');

  @override
  bool get showCongratulations {
    _$showCongratulationsAtom.context
        .enforceReadPolicy(_$showCongratulationsAtom);
    _$showCongratulationsAtom.reportObserved();
    return super.showCongratulations;
  }

  @override
  set showCongratulations(bool value) {
    _$showCongratulationsAtom.context.conditionallyRunInAction(() {
      super.showCongratulations = value;
      _$showCongratulationsAtom.reportChanged();
    }, _$showCongratulationsAtom,
        name: '${_$showCongratulationsAtom.name}_set');
  }

  final _$setAchievementListAsyncAction = AsyncAction('setAchievementList');

  @override
  Future<void> setAchievementList(String userId) {
    return _$setAchievementListAsyncAction
        .run(() => super.setAchievementList(userId));
  }

  final _$deleteAchievementAsyncAction = AsyncAction('deleteAchievement');

  @override
  Future<void> deleteAchievement(String achievementId) {
    return _$deleteAchievementAsyncAction
        .run(() => super.deleteAchievement(achievementId));
  }

  final _$updateResultAchievementAsyncAction =
      AsyncAction('updateResultAchievement');

  @override
  Future<void> updateResultAchievement(
      String achievementId, bool result, String resultParameterValueId) {
    return _$updateResultAchievementAsyncAction.run(() => super
        .updateResultAchievement(
            achievementId, result, resultParameterValueId));
  }

  final _$setNewParameterValueAsDefaultAsyncAction =
      AsyncAction('setNewParameterValueAsDefault');

  @override
  Future<ParameterValue> setNewParameterValueAsDefault(
      NewParameterValueAsDefaultDTO newParameterAsDefaultDTO) {
    return _$setNewParameterValueAsDefaultAsyncAction.run(
        () => super.setNewParameterValueAsDefault(newParameterAsDefaultDTO));
  }

  final _$setParentParameterValueAsDefaultAsyncAction =
      AsyncAction('setParentParameterValueAsDefault');

  @override
  Future<void> setParentParameterValueAsDefault(
      String userId, String parameterId) {
    return _$setParentParameterValueAsDefaultAsyncAction
        .run(() => super.setParentParameterValueAsDefault(userId, parameterId));
  }

  final _$closeLoadingAsyncAction = AsyncAction('closeLoading');

  @override
  Future closeLoading() {
    return _$closeLoadingAsyncAction.run(() => super.closeLoading());
  }

  final _$_AchievementListStoreActionController =
      ActionController(name: '_AchievementListStore');

  @override
  dynamic setShowCongratulations(bool value) {
    final _$actionInfo = _$_AchievementListStoreActionController.startAction();
    try {
      return super.setShowCongratulations(value);
    } finally {
      _$_AchievementListStoreActionController.endAction(_$actionInfo);
    }
  }
}
