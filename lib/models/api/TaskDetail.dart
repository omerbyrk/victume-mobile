import 'ApiModelBase.dart';

class TaskDetail extends ApiModelBase{
  String id;
  String description;
  int order;
  String taskId;
  TaskDetail({this.id, this.description, this.order, this.taskId});

  factory TaskDetail.fromMap(Map<String, dynamic> map) {
    return TaskDetail(
        id: map["_id"],
        description: map["description"],
        order: map["order"],
        taskId: map["taskId"]);
  }
}
