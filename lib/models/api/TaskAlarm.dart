import 'package:victume_mobile/models/api/ApiModelBase.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

class TaskAlarm extends ApiModelBase {
  String id;
  DateTime alarmTime;
  String taskId;
  String userId;

  TaskAlarm({this.id, this.alarmTime, this.taskId, this.userId});

  factory TaskAlarm.fromMap(Map<String, dynamic> map) {
    return TaskAlarm(
        id: map["_id"],
        alarmTime: MapConverter.toDateTime(map["alarmTime"]),
        taskId: map["taskId"],
        userId: map["userId"]);
  }
}
