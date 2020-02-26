import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:victume_mobile/data/TaskAlarmApi.dart';
import 'package:victume_mobile/data/TaskResultApi.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/models/api/TaskAlarm.dart';
import 'package:victume_mobile/models/api/TaskResult.dart';
import 'package:victume_mobile/stores/base_store.dart';

part 'task_detail_store.g.dart';

class TaskDetailStore = _TaskDetailStore with _$TaskDetailStore;

abstract class _TaskDetailStore extends BaseStore with Store {
  TaskAlarmApi _taskAlarmApi = appComponent.getTaskAlarmApi();
  TaskResultApi _taskResultApi = appComponent.getTaskResultApi();

  @observable
  TaskAlarm taskAlarm;

  @observable
  TaskResult todayResult;

  @computed
  bool get hasAlarm => taskAlarm != null;

  @computed
  bool get hasResult => todayResult != null;

  @action
  Future<void> setTaskAlarm(String taskId, String userId) async {
    try {
      this.loading = true;
      taskAlarm = await _taskAlarmApi.getBy(userId, taskId);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<void> saveOrUpdateTaskAlarm(TaskAlarmDTO taskAlarmDTO) async {
    try {
      this.loading = true;
      dynamic result;
      if (this.hasAlarm) {
        result = await _taskAlarmApi.update(this.taskAlarm.id, taskAlarmDTO);
        taskAlarm = TaskAlarm(
            id: this.taskAlarm.id,
            alarmTime: taskAlarmDTO.alarmTime,
            userId: this.taskAlarm.userId,
            taskId: this.taskAlarm.taskId);
      } else {
        result = await _taskAlarmApi.save(taskAlarmDTO);
        taskAlarm = result.taskAlarm;
      }
      this.uiMessageStore.setSuccess(result.message);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<void> setTodayResult(String taskId, String userId) async {
    try {
      this.loading = true;
      todayResult = await _taskResultApi.getTodayResultBy(userId, taskId);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<bool> insertTodayResult(TaskResultDTO taskResultDTO) async {
    try {
      this.loading = true;
      todayResult = await _taskResultApi.insert(taskResultDTO);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
    return todayResult?.result ?? false;
  }

  @action
  closeLoading() async {
    this.loading = _taskAlarmApi.onProcess || _taskResultApi.onProcess;
  }
}
