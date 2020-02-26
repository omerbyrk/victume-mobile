import 'package:victume_mobile/models/api/ApiModelBase.dart';
import 'package:victume_mobile/models/api/TaskDetail.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

class TaskView extends ApiModelBase {
  String id;
  String title;
  String warning;
  int order;
  String programId;
  List<TaskDetail> taskDetails;

  TaskView(
      {this.id,
      this.title,
      this.warning,
      this.order,
      this.programId,
      this.taskDetails});

  factory TaskView.fromMap(Map<String, dynamic> map) {
    return TaskView(
        id: map["_id"],
        title: map["title"],
        warning: map["warning"],
        order: map["order"],
        programId: map["programId"],
        taskDetails: MapConverter.toList<TaskDetail>(map["taskDetails"],
            (taskDetail) => TaskDetail.fromMap(taskDetail)));
  }
}
