// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserProfileStore on _UserProfileStore, Store {
  final _$authenticatedUserAtom =
      Atom(name: '_UserProfileStore.authenticatedUser');

  @override
  UserView get authenticatedUser {
    _$authenticatedUserAtom.context.enforceReadPolicy(_$authenticatedUserAtom);
    _$authenticatedUserAtom.reportObserved();
    return super.authenticatedUser;
  }

  @override
  set authenticatedUser(UserView value) {
    _$authenticatedUserAtom.context.conditionallyRunInAction(() {
      super.authenticatedUser = value;
      _$authenticatedUserAtom.reportChanged();
    }, _$authenticatedUserAtom, name: '${_$authenticatedUserAtom.name}_set');
  }

  final _$authUserParametersAtom =
      Atom(name: '_UserProfileStore.authUserParameters');

  @override
  ObservableList<ParameterAndDefaultValue> get authUserParameters {
    _$authUserParametersAtom.context
        .enforceReadPolicy(_$authUserParametersAtom);
    _$authUserParametersAtom.reportObserved();
    return super.authUserParameters;
  }

  @override
  set authUserParameters(ObservableList<ParameterAndDefaultValue> value) {
    _$authUserParametersAtom.context.conditionallyRunInAction(() {
      super.authUserParameters = value;
      _$authUserParametersAtom.reportChanged();
    }, _$authUserParametersAtom, name: '${_$authUserParametersAtom.name}_set');
  }

  final _$authUserNotificationsAtom =
      Atom(name: '_UserProfileStore.authUserNotifications');

  @override
  NotificationUserInfo get authUserNotifications {
    _$authUserNotificationsAtom.context
        .enforceReadPolicy(_$authUserNotificationsAtom);
    _$authUserNotificationsAtom.reportObserved();
    return super.authUserNotifications;
  }

  @override
  set authUserNotifications(NotificationUserInfo value) {
    _$authUserNotificationsAtom.context.conditionallyRunInAction(() {
      super.authUserNotifications = value;
      _$authUserNotificationsAtom.reportChanged();
    }, _$authUserNotificationsAtom,
        name: '${_$authUserNotificationsAtom.name}_set');
  }

  final _$authUserProgramsAtom =
      Atom(name: '_UserProfileStore.authUserPrograms');

  @override
  ObservableList<UserProgramView> get authUserPrograms {
    _$authUserProgramsAtom.context.enforceReadPolicy(_$authUserProgramsAtom);
    _$authUserProgramsAtom.reportObserved();
    return super.authUserPrograms;
  }

  @override
  set authUserPrograms(ObservableList<UserProgramView> value) {
    _$authUserProgramsAtom.context.conditionallyRunInAction(() {
      super.authUserPrograms = value;
      _$authUserProgramsAtom.reportChanged();
    }, _$authUserProgramsAtom, name: '${_$authUserProgramsAtom.name}_set');
  }

  final _$loaddedNotificationImagesAtom =
      Atom(name: '_UserProfileStore.loaddedNotificationImages');

  @override
  ObservableMap<String, String> get loaddedNotificationImages {
    _$loaddedNotificationImagesAtom.context
        .enforceReadPolicy(_$loaddedNotificationImagesAtom);
    _$loaddedNotificationImagesAtom.reportObserved();
    return super.loaddedNotificationImages;
  }

  @override
  set loaddedNotificationImages(ObservableMap<String, String> value) {
    _$loaddedNotificationImagesAtom.context.conditionallyRunInAction(() {
      super.loaddedNotificationImages = value;
      _$loaddedNotificationImagesAtom.reportChanged();
    }, _$loaddedNotificationImagesAtom,
        name: '${_$loaddedNotificationImagesAtom.name}_set');
  }

  final _$authUserProgramDataCountAtom =
      Atom(name: '_UserProfileStore.authUserProgramDataCount');

  @override
  int get authUserProgramDataCount {
    _$authUserProgramDataCountAtom.context
        .enforceReadPolicy(_$authUserProgramDataCountAtom);
    _$authUserProgramDataCountAtom.reportObserved();
    return super.authUserProgramDataCount;
  }

  @override
  set authUserProgramDataCount(int value) {
    _$authUserProgramDataCountAtom.context.conditionallyRunInAction(() {
      super.authUserProgramDataCount = value;
      _$authUserProgramDataCountAtom.reportChanged();
    }, _$authUserProgramDataCountAtom,
        name: '${_$authUserProgramDataCountAtom.name}_set');
  }

  final _$showNotificationsAtom =
      Atom(name: '_UserProfileStore.showNotifications');

  @override
  bool get showNotifications {
    _$showNotificationsAtom.context.enforceReadPolicy(_$showNotificationsAtom);
    _$showNotificationsAtom.reportObserved();
    return super.showNotifications;
  }

  @override
  set showNotifications(bool value) {
    _$showNotificationsAtom.context.conditionallyRunInAction(() {
      super.showNotifications = value;
      _$showNotificationsAtom.reportChanged();
    }, _$showNotificationsAtom, name: '${_$showNotificationsAtom.name}_set');
  }

  final _$setNotificationImageAsyncAction = AsyncAction('setNotificationImage');

  @override
  Future<void> setNotificationImage(String notificationId) {
    return _$setNotificationImageAsyncAction
        .run(() => super.setNotificationImage(notificationId));
  }

  final _$setAuthUserAsyncAction = AsyncAction('setAuthUser');

  @override
  Future<void> setAuthUser() {
    return _$setAuthUserAsyncAction.run(() => super.setAuthUser());
  }

  final _$setAuthUserParametersAsyncAction =
      AsyncAction('setAuthUserParameters');

  @override
  Future<void> setAuthUserParameters() {
    return _$setAuthUserParametersAsyncAction
        .run(() => super.setAuthUserParameters());
  }

  final _$setAuthUserProgramsAsyncAction = AsyncAction('setAuthUserPrograms');

  @override
  Future<void> setAuthUserPrograms({int limit = 5}) {
    return _$setAuthUserProgramsAsyncAction
        .run(() => super.setAuthUserPrograms(limit: limit));
  }

  final _$uploadPhotoAsyncAction = AsyncAction('uploadPhoto');

  @override
  Future<void> uploadPhoto(File photo) {
    return _$uploadPhotoAsyncAction.run(() => super.uploadPhoto(photo));
  }

  final _$setAuthUserNotificationsAsyncAction =
      AsyncAction('setAuthUserNotifications');

  @override
  Future<void> setAuthUserNotifications({int limit = 8}) {
    return _$setAuthUserNotificationsAsyncAction
        .run(() => super.setAuthUserNotifications(limit: limit));
  }

  final _$setReaddedAllAuthUserNotificationsAsyncAction =
      AsyncAction('setReaddedAllAuthUserNotifications');

  @override
  Future<void> setReaddedAllAuthUserNotifications() {
    return _$setReaddedAllAuthUserNotificationsAsyncAction
        .run(() => super.setReaddedAllAuthUserNotifications());
  }

  final _$closeLoadingAsyncAction = AsyncAction('closeLoading');

  @override
  Future closeLoading() {
    return _$closeLoadingAsyncAction.run(() => super.closeLoading());
  }

  final _$_UserProfileStoreActionController =
      ActionController(name: '_UserProfileStore');

  @override
  void setShowNotificationsValue(bool newValue) {
    final _$actionInfo = _$_UserProfileStoreActionController.startAction();
    try {
      return super.setShowNotificationsValue(newValue);
    } finally {
      _$_UserProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  ParameterAndDefaultValue findFromAuthUserParamsBy(String parameterId) {
    final _$actionInfo = _$_UserProfileStoreActionController.startAction();
    try {
      return super.findFromAuthUserParamsBy(parameterId);
    } finally {
      _$_UserProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearStore() {
    final _$actionInfo = _$_UserProfileStoreActionController.startAction();
    try {
      return super.clearStore();
    } finally {
      _$_UserProfileStoreActionController.endAction(_$actionInfo);
    }
  }
}
