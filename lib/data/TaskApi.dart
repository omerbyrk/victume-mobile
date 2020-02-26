import 'package:victume_mobile/data/network/constants/endpoints.dart';
import 'package:victume_mobile/data/network/dio_client.dart';
import 'package:victume_mobile/models/api/TaskView.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'BaseApi.dart';

class TaskApi extends BaseApi {
  TaskApi(DioClient dioClient) : super(dioClient);

  Future<List<TaskView>> getTaskListBy(String programId) async {
    dynamic response = await dioClient
        .get("${Endpoints.get_task_view_by_program_id}/$programId");

    return MapConverter.toList<TaskView>(
        response["result"]["data"], (task) => TaskView.fromMap(task));
  }
}
