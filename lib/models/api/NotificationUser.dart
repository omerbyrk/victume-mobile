import 'package:victume_mobile/models/api/ApiModelBase.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

class NotificationUser extends ApiModelBase {
  String id;
  String userId;
  String type;
  dynamic data;
  String title;
  String content;
  String fromUserId;
  DateTime notificationDate;
  bool isRead;

  NotificationUser(
      {this.id,
      this.userId,
      this.content,
      this.data,
      this.fromUserId,
      this.isRead,
      this.notificationDate,
      this.title,
      this.type});

  factory NotificationUser.fromMap(Map<String, dynamic> map) {
    return NotificationUser(
        id: map["_id"],
        userId: map["userId"],
        type: map["type"],
        data: map["data"],
        title: map["title"],
        content: map["content"],
        fromUserId: map["fromUserId"],
        notificationDate: MapConverter.toDateTime(map["notificationDate"]),
        isRead: map["isRead"]);
  }
}
