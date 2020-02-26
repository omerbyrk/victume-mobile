// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskStore on _TaskStore, Store {
  final _$taskListAtom = Atom(name: '_TaskStore.taskList');

  @override
  ObservableList<TaskView> get taskList {
    _$taskListAtom.context.enforceReadPolicy(_$taskListAtom);
    _$taskListAtom.reportObserved();
    return super.taskList;
  }

  @override
  set taskList(ObservableList<TaskView> value) {
    _$taskListAtom.context.conditionallyRunInAction(() {
      super.taskList = value;
      _$taskListAtom.reportChanged();
    }, _$taskListAtom, name: '${_$taskListAtom.name}_set');
  }

  final _$programAtom = Atom(name: '_TaskStore.program');

  @override
  Program get program {
    _$programAtom.context.enforceReadPolicy(_$programAtom);
    _$programAtom.reportObserved();
    return super.program;
  }

  @override
  set program(Program value) {
    _$programAtom.context.conditionallyRunInAction(() {
      super.program = value;
      _$programAtom.reportChanged();
    }, _$programAtom, name: '${_$programAtom.name}_set');
  }

  final _$programDialogAtom = Atom(name: '_TaskStore.programDialog');

  @override
  ProgramDialog get programDialog {
    _$programDialogAtom.context.enforceReadPolicy(_$programDialogAtom);
    _$programDialogAtom.reportObserved();
    return super.programDialog;
  }

  @override
  set programDialog(ProgramDialog value) {
    _$programDialogAtom.context.conditionallyRunInAction(() {
      super.programDialog = value;
      _$programDialogAtom.reportChanged();
    }, _$programDialogAtom, name: '${_$programDialogAtom.name}_set');
  }

  final _$setProgramAsyncAction = AsyncAction('setProgram');

  @override
  Future<void> setProgram(String programId) {
    return _$setProgramAsyncAction.run(() => super.setProgram(programId));
  }

  final _$setProgramDialogAsyncAction = AsyncAction('setProgramDialog');

  @override
  Future<void> setProgramDialog(String programId) {
    return _$setProgramDialogAsyncAction
        .run(() => super.setProgramDialog(programId));
  }

  final _$setTaskListAsyncAction = AsyncAction('setTaskList');

  @override
  Future<void> setTaskList(String programId) {
    return _$setTaskListAsyncAction.run(() => super.setTaskList(programId));
  }

  final _$closeLoadingAsyncAction = AsyncAction('closeLoading');

  @override
  Future closeLoading() {
    return _$closeLoadingAsyncAction.run(() => super.closeLoading());
  }
}
