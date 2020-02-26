import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:victume_mobile/data/NotificationUserApi.dart';
import 'package:victume_mobile/data/ParameterApi.dart';
import 'package:victume_mobile/data/ProfileApi.dart';
import 'package:victume_mobile/data/UserApi.dart';
import 'package:victume_mobile/data/UserProgramApi.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/models/api/ParameterAndDefaultValue.dart';
import 'package:victume_mobile/models/api/UserProgramView.dart';
import 'package:victume_mobile/models/api/UserView.dart';

import '../base_store.dart';

part 'user_profile_store.g.dart';

class UserProfileStore = _UserProfileStore with _$UserProfileStore;

abstract class _UserProfileStore extends BaseStore with Store {
  UserApi _userApi = appComponent.getUserApi();
  ParameterApi _parameterApi = appComponent.getParameterApi();
  UserProgramApi _userProgramApi = appComponent.getUserProgramApi();
  ProfileApi _profileApi = appComponent.getProfileApi();
  NotificationUserApi _notificationUserApi =
      appComponent.getNotificationUserApi();

  @observable
  UserView authenticatedUser;

  @observable
  ObservableList<ParameterAndDefaultValue> authUserParameters =
      new ObservableList<ParameterAndDefaultValue>();

  @observable
  NotificationUserInfo authUserNotifications;

  @observable
  ObservableList<UserProgramView> authUserPrograms =
      new ObservableList<UserProgramView>();

  @observable
  ObservableMap<String, String> loaddedNotificationImages =
      new ObservableMap<String, String>();

  @observable
  int authUserProgramDataCount = 0;

  @observable
  bool showNotifications = false;

  @action
  void setShowNotificationsValue(bool newValue) {
    this.showNotifications = newValue;
  }

  @action
  Future<void> setNotificationImage(String notificationId) async {
    try {
      if (!loaddedNotificationImages.containsKey(notificationId)) {
        String notificationImage =
            await _notificationUserApi.getNotificationImage(notificationId);
        loaddedNotificationImages.putIfAbsent(
            notificationId, () => notificationImage);
        loaddedNotificationImages =
            new ObservableMap.of(loaddedNotificationImages);
      }
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    }
  }

  @action
  Future<void> setAuthUser() async {
    try {
      this.loading = true;
      authenticatedUser = await _userApi.authenticatedUser();
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<void> setAuthUserParameters() async {
    try {
      this.loading = true;
      authUserParameters = ObservableList.of(
          await _parameterApi.authenticatedUserDefaultParameters());
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<void> setAuthUserPrograms({int limit = 5}) async {
    try {
      this.loading = true;
      AuthUserProgramsResult result =
          await _userProgramApi.authUserProgramsLimit(limit);
      authUserPrograms = ObservableList.of(result.userPrograms);
      authUserProgramDataCount = result.dataCount;
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<void> uploadPhoto(File photo) async {
    try {
      this.loading = true;
      String message = await _profileApi.uploadPhoto(
          this.authenticatedUser.profile.id, photo);
      await setAuthUser();
      uiMessageStore.setSuccess(message);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<void> setAuthUserNotifications({int limit: 8}) async {
    try {
      authUserNotifications =
          await _notificationUserApi.getAuthUserNotificationInfo(limit);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    }
  }

  @action
  Future<void> setReaddedAllAuthUserNotifications() async {
    try {
      await _notificationUserApi.setReaddedAllAuthUserNotifications();
      setAuthUserNotifications();
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    }
  }

  @action
  ParameterAndDefaultValue findFromAuthUserParamsBy(String parameterId) {
    return this.authUserParameters.firstWhere(
        (params) => params.id == parameterId,
        orElse: () => this.authUserParameters.first);
  }

  @action
  void clearStore() {
    authenticatedUser = null;
    authUserParameters = new ObservableList<ParameterAndDefaultValue>();
    authUserNotifications = null;
    authUserPrograms = new ObservableList<UserProgramView>();
    authUserProgramDataCount = 0;
    showNotifications = false;
  }

  @action
  closeLoading() async {
    this.loading = _userApi.onProcess ||
        _parameterApi.onProcess ||
        _userProgramApi.onProcess ||
        _profileApi.onProcess;
  }
}
