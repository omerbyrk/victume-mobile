// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskDetailStore on _TaskDetailStore, Store {
  Computed<bool> _$hasAlarmComputed;

  @override
  bool get hasAlarm =>
      (_$hasAlarmComputed ??= Computed<bool>(() => super.hasAlarm)).value;
  Computed<bool> _$hasResultComputed;

  @override
  bool get hasResult =>
      (_$hasResultComputed ??= Computed<bool>(() => super.hasResult)).value;

  final _$taskAlarmAtom = Atom(name: '_TaskDetailStore.taskAlarm');

  @override
  TaskAlarm get taskAlarm {
    _$taskAlarmAtom.context.enforceReadPolicy(_$taskAlarmAtom);
    _$taskAlarmAtom.reportObserved();
    return super.taskAlarm;
  }

  @override
  set taskAlarm(TaskAlarm value) {
    _$taskAlarmAtom.context.conditionallyRunInAction(() {
      super.taskAlarm = value;
      _$taskAlarmAtom.reportChanged();
    }, _$taskAlarmAtom, name: '${_$taskAlarmAtom.name}_set');
  }

  final _$todayResultAtom = Atom(name: '_TaskDetailStore.todayResult');

  @override
  TaskResult get todayResult {
    _$todayResultAtom.context.enforceReadPolicy(_$todayResultAtom);
    _$todayResultAtom.reportObserved();
    return super.todayResult;
  }

  @override
  set todayResult(TaskResult value) {
    _$todayResultAtom.context.conditionallyRunInAction(() {
      super.todayResult = value;
      _$todayResultAtom.reportChanged();
    }, _$todayResultAtom, name: '${_$todayResultAtom.name}_set');
  }

  final _$setTaskAlarmAsyncAction = AsyncAction('setTaskAlarm');

  @override
  Future<void> setTaskAlarm(String taskId, String userId) {
    return _$setTaskAlarmAsyncAction
        .run(() => super.setTaskAlarm(taskId, userId));
  }

  final _$saveOrUpdateTaskAlarmAsyncAction =
      AsyncAction('saveOrUpdateTaskAlarm');

  @override
  Future<void> saveOrUpdateTaskAlarm(TaskAlarmDTO taskAlarmDTO) {
    return _$saveOrUpdateTaskAlarmAsyncAction
        .run(() => super.saveOrUpdateTaskAlarm(taskAlarmDTO));
  }

  final _$setTodayResultAsyncAction = AsyncAction('setTodayResult');

  @override
  Future<void> setTodayResult(String taskId, String userId) {
    return _$setTodayResultAsyncAction
        .run(() => super.setTodayResult(taskId, userId));
  }

  final _$insertTodayResultAsyncAction = AsyncAction('insertTodayResult');

  @override
  Future<bool> insertTodayResult(TaskResultDTO taskResultDTO) {
    return _$insertTodayResultAsyncAction
        .run(() => super.insertTodayResult(taskResultDTO));
  }

  final _$closeLoadingAsyncAction = AsyncAction('closeLoading');

  @override
  Future closeLoading() {
    return _$closeLoadingAsyncAction.run(() => super.closeLoading());
  }
}
