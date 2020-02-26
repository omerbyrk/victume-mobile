import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'dart:io';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/data/UserFileApi.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/models/api/UserFile.dart';

import '../base_store.dart';
part 'measurement_list_store.g.dart';

class MeasurementListStore = _MeasurementListStore with _$MeasurementListStore;

abstract class _MeasurementListStore extends BaseStore with Store {
  UserFileApi _userFileApi = appComponent.getUserFileApi();

  @observable
  ObservableList<UserFile> measurementList = new ObservableList();

  @computed
  bool get isReadyMeasurementList =>
      measurementList != null && measurementList.isNotEmpty;

  @action
  Future<void> setMeasurementList(String userId,
      {String fileType = UserFileTypes.MEASUREMENT}) async {
    try {
      this.loading = true;
      measurementList = ObservableList.of(await _userFileApi
              .getListBy({"userId": userId, "fileType": fileType}) ??
          []);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<bool> uploadMeasurement(String userId, File file,
      {String fileType = UserFileTypes.MEASUREMENT}) async {
    try {
      this.loading = true;
      UserFileProcessResult result =
          await _userFileApi.insertBy(file, fileType, userId);
      this.uiMessageStore.setSuccess(result.message);
      return result.success;
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
    return false;
  }

  @action
  Future<void> deleteMeasurement(String userFileId) async {
    try {
      this.loading = true;
      UserFileProcessResult result = await _userFileApi.delete(userFileId);
      this.uiMessageStore.setSuccess(result.message);
      return result.success;
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
    return false;
  }

  @action
  closeLoading() async {
    this.loading = _userFileApi.onProcess;
  }
}
