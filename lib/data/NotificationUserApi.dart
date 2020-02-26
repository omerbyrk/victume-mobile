import 'package:victume_mobile/data/BaseApi.dart';
import 'package:victume_mobile/models/api/NotificationUser.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'network/constants/endpoints.dart';

class NotificationUserInfo {
  List<NotificationUser> notifications;
  int totalNotifications;
  int unReadNotifications;
  NotificationUserInfo(
      {this.notifications, this.totalNotifications, this.unReadNotifications});
}

class NotificationUserDTO {
  String type;
  dynamic data;

  NotificationUserDTO({this.type, this.data});

  Map<String, dynamic> toMap() {
    return {"type": type, "data": data};
  }
}

class NotificationUserApi extends BaseApi {
  NotificationUserApi(dioClient) : super(dioClient);

  Future<NotificationUserInfo> getAuthUserNotificationInfo(int limit) async {
    dynamic response = await this.dioClient.get(
        Endpoints.get_auth_user_notifications,
        queryParameters: {"pageIndex": 0, "limit": limit});

    return NotificationUserInfo(
        notifications: MapConverter.toList<NotificationUser>(
            response["result"]["notifications"],
            (parameter) => NotificationUser.fromMap(parameter)),
        totalNotifications: response["result"]["totalNotifications"],
        unReadNotifications: response["result"]["unReadNotifications"]);
  }

  Future<bool> setReaddedAllAuthUserNotifications() async {
    dynamic response = await this
        .dioClient
        .patch(Endpoints.set_readed_all_auth_user_notifications);
    return response["success"];
  }

  Future<bool> sendNotificationToMentor(
      NotificationUserDTO notificationUserDTO) async {
    dynamic response = await this.dioClient.post(
        Endpoints.send_notification_mentor,
        data: {"notification": notificationUserDTO.toMap()});
    return response["success"];
  }

    Future<String> getNotificationImage(
      String notificationUserId) async {
    dynamic response = await this.dioClient.get(
        "${Endpoints.get_notification_image}/$notificationUserId");
    print(response["result"]["image"]);
    return response["result"]["image"];
  }
}
