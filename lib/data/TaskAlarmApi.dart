import 'package:victume_mobile/data/network/constants/endpoints.dart';
import 'package:victume_mobile/data/network/dio_client.dart';
import 'package:victume_mobile/models/api/TaskAlarm.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'BaseApi.dart';

class TaskAlarmDTO {
  DateTime alarmTime;
  String taskId;
  String userId;

  TaskAlarmDTO({this.alarmTime, this.taskId, this.userId});

  Map<String, dynamic> toMap() {
    return {
      "alarmTime": alarmTime.toUtc().toIso8601String(),
      "taskId": taskId,
      "userId": userId
    };
  }
}

class TaskAlarmSaveResult {
  String message;
  TaskAlarm taskAlarm;

  TaskAlarmSaveResult({this.taskAlarm, this.message});
}

class TaskAlarmUpdateResult {
  String message;
  bool result;

  TaskAlarmUpdateResult({this.message, this.result});
}

class TaskAlarmApi extends BaseApi {
  TaskAlarmApi(DioClient dioClient) : super(dioClient);

  Future<TaskAlarm> getBy(String userId, String taskId) async {
    dynamic response = await dioClient.get("${Endpoints.find_task_alarm}/",
        queryParameters: {"userId": userId, "taskId": taskId});

    return MapConverter.toObject<TaskAlarm>(response["result"]["data"],
        (taskAlarm) => TaskAlarm.fromMap(taskAlarm));
  }

  Future<TaskAlarmSaveResult> save(TaskAlarmDTO taskAlarmDTO) async {
    print(taskAlarmDTO.toMap());
    dynamic response = await dioClient.post("${Endpoints.task_alarm}",
        data: {"insert": taskAlarmDTO.toMap()});

    return TaskAlarmSaveResult(
        taskAlarm: MapConverter.toObject<TaskAlarm>(response["result"]["data"],
            (taskAlarm) => TaskAlarm.fromMap(taskAlarm)),
        message: response["message"]);
  }

  Future<TaskAlarmUpdateResult> update(
      String taskAlarmId, TaskAlarmDTO taskAlarmDTO) async {
    dynamic response = await dioClient.patch(
        "${Endpoints.task_alarm}/$taskAlarmId",
        data: {"update": taskAlarmDTO.toMap()});

    return TaskAlarmUpdateResult(
        result: response["success"], message: response["message"]);
  }
}
