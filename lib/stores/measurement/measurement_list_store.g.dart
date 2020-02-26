// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeasurementListStore on _MeasurementListStore, Store {
  Computed<bool> _$isReadyMeasurementListComputed;

  @override
  bool get isReadyMeasurementList => (_$isReadyMeasurementListComputed ??=
          Computed<bool>(() => super.isReadyMeasurementList))
      .value;

  final _$measurementListAtom =
      Atom(name: '_MeasurementListStore.measurementList');

  @override
  ObservableList<UserFile> get measurementList {
    _$measurementListAtom.context.enforceReadPolicy(_$measurementListAtom);
    _$measurementListAtom.reportObserved();
    return super.measurementList;
  }

  @override
  set measurementList(ObservableList<UserFile> value) {
    _$measurementListAtom.context.conditionallyRunInAction(() {
      super.measurementList = value;
      _$measurementListAtom.reportChanged();
    }, _$measurementListAtom, name: '${_$measurementListAtom.name}_set');
  }

  final _$setMeasurementListAsyncAction = AsyncAction('setMeasurementList');

  @override
  Future<void> setMeasurementList(String userId,
      {String fileType = UserFileTypes.MEASUREMENT}) {
    return _$setMeasurementListAsyncAction
        .run(() => super.setMeasurementList(userId, fileType: fileType));
  }

  final _$uploadMeasurementAsyncAction = AsyncAction('uploadMeasurement');

  @override
  Future<bool> uploadMeasurement(String userId, File file,
      {String fileType = UserFileTypes.MEASUREMENT}) {
    return _$uploadMeasurementAsyncAction
        .run(() => super.uploadMeasurement(userId, file, fileType: fileType));
  }

  final _$deleteMeasurementAsyncAction = AsyncAction('deleteMeasurement');

  @override
  Future<void> deleteMeasurement(String userFileId) {
    return _$deleteMeasurementAsyncAction
        .run(() => super.deleteMeasurement(userFileId));
  }

  final _$closeLoadingAsyncAction = AsyncAction('closeLoading');

  @override
  Future closeLoading() {
    return _$closeLoadingAsyncAction.run(() => super.closeLoading());
  }
}
