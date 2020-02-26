import 'package:mobx/mobx.dart';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/data/NotificationUserApi.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';

part 'notification_sender.g.dart';

class NotificationSenderStore = _NotificationSenderStore
    with _$NotificationSenderStore;

abstract class _NotificationSenderStore with Store {
  NotificationUserApi _notificationUserApi =
      appComponent.getNotificationUserApi();
  UserProfileStore _userProfileStore = appComponent.getUserProfileStore();

  Future<void> sendAchievementDoneNotification(String parameterName) async {
    _notificationUserApi.sendNotificationToMentor(
        NotificationUserDTO(type: NotificationTypes.ACHIEVEMENT_DONE, data: {
      "fullname": _userProfileStore?.authenticatedUser?.profile?.fullname,
      "parameterName": parameterName
    }));
  }

  Future<void> sendAchievementBackNotification(String parameterName) async {
    _notificationUserApi.sendNotificationToMentor(
        NotificationUserDTO(type: NotificationTypes.ACHIEVEMENT_BACK, data: {
      "fullname": _userProfileStore?.authenticatedUser?.profile?.fullname,
      "parameterName": parameterName
    }));
  }

  Future<void> sendAchievementNewNotification(String parameterName) async {
    _notificationUserApi.sendNotificationToMentor(
        NotificationUserDTO(type: NotificationTypes.ACHIEVEMENT_NEW, data: {
      "fullname": _userProfileStore?.authenticatedUser?.profile?.fullname,
      "parameterName": parameterName
    }));
  }

  Future<void> sendTaskDoneNotification(
      String programName, String taskName) async {
    _notificationUserApi.sendNotificationToMentor(
        NotificationUserDTO(type: NotificationTypes.TASK_DONE, data: {
      "fullname": _userProfileStore?.authenticatedUser?.profile?.fullname,
      "programName": programName,
      "taskName": taskName
    }));
  }

  Future<void> sendParameterNotFoundNotification() async {
    _notificationUserApi.sendNotificationToMentor(
        NotificationUserDTO(type: NotificationTypes.PARAMETER_NOT_FOUND, data: {
      "fullname": _userProfileStore?.authenticatedUser?.profile?.fullname,
    }));
  }
}
