import 'package:victume_mobile/models/api/ApiModelBase.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

class TaskResult extends ApiModelBase {
  String id;
  DateTime resultTime;
  bool result;
  String taskId;
  String userId;

  TaskResult({this.id, this.resultTime, this.result, this.taskId, this.userId});

  factory TaskResult.fromMap(Map<String, dynamic> map) {
    return TaskResult(
        id: map["_id"],
        resultTime: MapConverter.toDateTime(map["resultTime"]),
        result: map["result"],
        taskId: map["taskId"],
        userId: map["userId"]);
  }
}
