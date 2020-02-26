import 'package:victume_mobile/data/network/constants/endpoints.dart';
import 'package:victume_mobile/data/network/dio_client.dart';
import 'package:victume_mobile/models/api/TaskResult.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'BaseApi.dart';

class TaskResultDTO {
  String userId;
  String taskId;
  bool result;

  TaskResultDTO({this.userId, this.taskId, this.result});

  Map<String, dynamic> toMap() {
    return {"userId": userId, "taskId": taskId, "result": result};
  }
}

class TaskResultApi extends BaseApi {
  TaskResultApi(DioClient dioClient) : super(dioClient);

  Future<TaskResult> getTodayResultBy(String userId, String taskId) async {
    dynamic response = await dioClient.get(
        "${Endpoints.get_today_task_result}/",
        queryParameters: {"userId": userId, "taskId": taskId});

    return MapConverter.toObject<TaskResult>(
        response["result"]["data"], (result) => TaskResult.fromMap(result));
  }

  Future<TaskResult> insert(TaskResultDTO taskResultDTO) async {
    dynamic response = await dioClient.post("${Endpoints.task_result}/",
        data: {"insert": taskResultDTO.toMap()});

    return MapConverter.toObject<TaskResult>(
        response["result"]["data"], (result) => TaskResult.fromMap(result));
  }
}
