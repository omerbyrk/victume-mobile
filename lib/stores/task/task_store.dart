import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:victume_mobile/data/ProgramApi.dart';
import 'package:victume_mobile/data/ProgramDialogApi.dart';
import 'package:victume_mobile/data/TaskApi.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/models/api/Program.dart';
import 'package:victume_mobile/models/api/ProgramDialog.dart';
import 'package:victume_mobile/models/api/TaskView.dart';
import 'package:victume_mobile/stores/base_store.dart';
import 'package:victume_mobile/stores/ui_message/ui_message_store.dart';

part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore extends BaseStore with Store {
  TaskApi _taskApi = appComponent.getTaskApi();
  ProgramApi _programApi = appComponent.getProgramApi();

  ProgramDialogApi _programDialogApi = appComponent.getProgramDialogApi();

  @observable
  ObservableList<TaskView> taskList = new ObservableList();
  @observable
  Program program;

  @observable
  ProgramDialog programDialog;

  @action
  Future<void> setProgram(String programId) async {
    try {
      this.loading = true;
      program = await _programApi.getBy(programId);
    } on DioError catch (err) {
      uiMessageStore.message = err.response.data["message"];
      uiMessageStore.type = MESSAGE_TYPE.ERROR;
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<void> setProgramDialog(String programId) async {
    try {
      this.loading = true;
      programDialog = await _programDialogApi.getBy(programId);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<void> setTaskList(String programId) async {
    try {
      this.loading = true;
      taskList = ObservableList.of(await _taskApi.getTaskListBy(programId));
    } on DioError catch (err) {
      uiMessageStore.message = err.response.data["message"];
      uiMessageStore.type = MESSAGE_TYPE.ERROR;
    } finally {
      this.closeLoading();
    }
  }

  @action
  closeLoading() async {
    this.loading = _taskApi.onProcess ||
        _programApi.onProcess ||
        _programDialogApi.onProcess;
  }
}
