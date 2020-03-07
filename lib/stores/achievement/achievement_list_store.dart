import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:victume_mobile/data/AchievementApi.dart';
import 'package:victume_mobile/data/ParameterValueApi.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/models/api/AchievementView.dart';
import 'package:victume_mobile/models/api/ParameterValue.dart';
import 'package:victume_mobile/stores/base_store.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';

part 'achievement_list_store.g.dart';

class AchievementListStore = _AchievementListStore with _$AchievementListStore;

abstract class _AchievementListStore extends BaseStore with Store {
  AchievementApi _achievementApi = appComponent.getAchievementApi();
  ParameterValueApi _parameterValueApi = appComponent.getParameterValueApi();
  UserProfileStore _userProfileStore = appComponent.getUserProfileStore();

  @observable
  ObservableList<AchievementView> achievementList = new ObservableList();

  @computed
  bool get isReadyAchievementList =>
      achievementList != null && achievementList.isNotEmpty;

  @observable
  bool showCongratulations = false;

  @action
  Future<void> setAchievementList(String userId) async {
    try {
      this.loading = true;
      achievementList = ObservableList.of(
          await _achievementApi.getListBy({"userId": userId}) ?? []);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<void> deleteAchievement(String achievementId) async {
    try {
      this.loading = true;
      String message = await _achievementApi.delete(achievementId);
      uiMessageStore.setSuccess(message);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<void> updateResultAchievement(
      String achievementId, bool result, String resultParameterValueId) async {
    try {
      this.loading = true;
      await _achievementApi.updateBy(achievementId,
          {"result": result, "resultParameterValueId": resultParameterValueId});
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  Future<void> setNewParameterValue(
      String parameterValueId, String value) async {
    try {
      this.loading = true;
      await _parameterValueApi.update(parameterValueId, {"value": value});
      _userProfileStore.setAuthUserParameters();
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<ParameterValue> setNewParameterValueAsDefault(
      NewParameterValueAsDefaultDTO newParameterAsDefaultDTO) async {
    ParameterValue parameterValue;
    try {
      this.loading = true;
      parameterValue = await _parameterValueApi
          .setNewParameterValueAsDefault(newParameterAsDefaultDTO);
      _userProfileStore.setAuthUserParameters();
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
    return parameterValue;
  }

  @action
  Future<void> setParentParameterValueAsDefault(
      String userId, String parameterId) async {
    ParameterValue parameterValue;
    try {
      this.loading = true;
      parameterValue = await _parameterValueApi
          .setParentParameterValueAsDefault(userId, parameterId);
      _userProfileStore.setAuthUserParameters();
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
    return parameterValue;
  }

  @action
  closeLoading() async {
    this.loading = _achievementApi.onProcess;
  }

  @action
  setShowCongratulations(bool value) {
    this.showCongratulations = value;
  }
}
