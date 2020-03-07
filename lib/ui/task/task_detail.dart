import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:victume_mobile/constants/app_theme.dart';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/data/TaskAlarmApi.dart';
import 'package:victume_mobile/data/TaskResultApi.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/models/api/Program.dart';
import 'package:victume_mobile/models/api/ProgramDialog.dart';
import 'package:victume_mobile/models/api/TaskDetail.dart';
import 'package:victume_mobile/models/api/TaskView.dart';
import 'package:victume_mobile/stores/notification/notification_sender.dart';
import 'package:victume_mobile/stores/task/task_detail_store.dart';
import 'package:victume_mobile/stores/task/task_store.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';
import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:victume_mobile/widgets/custom_text_card_rounded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TaskDetailWidget extends StatefulWidget {
  final TaskView task;
  final Program program;
  final ProgramDialog programDialog;
  TaskDetailWidget(
      {Key key,
      @required this.task,
      @required this.program,
      @required this.programDialog})
      : super(key: key);

  @override
  _TaskDetailWidgetState createState() => _TaskDetailWidgetState();
}

class _TaskDetailWidgetState extends ScreenStatefulBase<TaskDetailWidget> {
  TaskDetailStore _taskDetailStore = TaskDetailStore();
  UserProfileStore _userProfileStore = appComponent.getUserProfileStore();
  NotificationSenderStore _notificationSenderStore =
      appComponent.getNotificationSenderStore();
  TaskStore _taskStore;
  ReactionDisposer loadindAutoRun;

  @override
  void initState() {
    super.initState();
    _taskStore = Provider.of<TaskStore>(context, listen: false);
    _taskDetailStore.setTaskAlarm(
        this.widget.task.id, _userProfileStore.authenticatedUser.id);
    _taskDetailStore.setTodayResult(
        this.widget.task.id, _userProfileStore.authenticatedUser.id);

    loadindAutoRun = autorun((_) {
      _taskStore.loading = _taskDetailStore.loading;
    }, delay: 25);
  }

  @override
  void dispose() {
    loadindAutoRun.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return isTaskDetailNullOrEmpty
        ? Container()
        : Stack(
            children: <Widget>[
              CustomRoundedTextCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: this.calSizeForDevice(10), bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              this.widget.task.title,
                              style: TextStyles.largeText.isBolder().ok(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    ...this
                        .widget
                        .task
                        .taskDetails
                        .map((taskDetail) => _buildTaskDetail(taskDetail)),
                    _buildTaskDetailWarning(),
                  ],
                ),
              ),
              _buildAlarmIcon(),
              _buildAllDoneIcon(),
              super.buildUIMessageHandler(_taskDetailStore),
            ],
          );
  }

  _buildAlarmIcon() {
    return Observer(builder: (_) {
      return Positioned(
        right: 0,
        top: 0,
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          child: InkWell(
            onTap: this._onAlarmButtonAction,
            child: Icon(
              Icons.alarm_add,
              color: this._taskDetailStore.hasAlarm
                  ? Colors.green
                  : Colors.blueGrey,
              size: this.calIconSize(IconSizeType.xMega),
            ),
          ),
        ),
      );
    });
  }

  _buildAllDoneIcon() {
    return Observer(builder: (_) {
      return this.widget.programDialog != null &&
              this.widget.programDialog.showDoneIcon
          ? Positioned(
              top: 0,
              right: this.calIconSize(IconSizeType.xMega) + 10,
              child: Observer(builder: (_) {
                return InkWell(
                  onTap: _onAllDoneButtonAction,
                  child: Icon(
                    Icons.done_all,
                    color: this._taskDetailStore.hasResult
                        ? Colors.green
                        : Colors.blueGrey,
                    size: this.calIconSize(IconSizeType.xMega),
                  ),
                );
              }),
            )
          : Container();
    });
  }

  _buildTaskDetail(TaskDetail taskDetail) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: this.calSizeForDevice(3.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.done,
            size: this.calIconSize(IconSizeType.Large),
            color: AppColors.green[500],
          ),
          SizedBox(
            width: this.calSizeForDevice(8),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: this.calSizeForDevice(5.0)),
              child: Text(
                taskDetail.description,
                style: TextStyles.smallText.isBolder().ok(),
                textAlign: TextAlign.justify,
              ),
            ),
          )
        ],
      ),
    );
  }

  get isTaskDetailNullOrEmpty =>
      this.widget.task.taskDetails == null ||
      this.widget.task.taskDetails.isEmpty;

  _buildTaskDetailWarning() {
    return Container(
      margin: EdgeInsets.only(top: this.calSizeForDevice(10)),
      child: this.widget.task.warning != null
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.warning,
                  color: Colors.deepOrange[900],
                  size: this.calIconSize(IconSizeType.Large),
                ),
                SizedBox(
                  width: this.calSizeForDevice(10),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      this.widget.task.warning,
                      style: TextStyles.smallText
                          .color(Colors.deepOrange[900])
                          .isBolder()
                          .ok(),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                )
              ],
            )
          : Container(),
    );
  }

  _onAlarmButtonAction() async {
    DatePicker.showTimePicker(context,
        currentTime: this._taskDetailStore.taskAlarm?.alarmTime ??
            DateTime(2019, 02, 15, 12, 30, 00),
        showTitleActions: true,
        theme: DatePickerTheme(
            doneStyle: TextStyles.largeText.primaryColor().isBolder().ok()),
        onConfirm: (datetime) async {
      if (datetime != null) {
        this._taskDetailStore.saveOrUpdateTaskAlarm(TaskAlarmDTO(
            alarmTime: datetime,
            userId: _userProfileStore.authenticatedUser.id,
            taskId: this.widget.task.id));
      }
    });
  }

  _onAllDoneButtonAction() async {
    if (!this._taskDetailStore.hasResult) {
      this.showAlertDialog(this.widget.programDialog.doneDialogTitle,
          this.widget.programDialog.doneDialogContent,
          onAcceptAction: () async {
        bool result = await this._taskDetailStore.insertTodayResult(
            TaskResultDTO(
                result: true,
                taskId: this.widget.task.id,
                userId: this._userProfileStore.authenticatedUser.id));

        this.showSuccessMessage(this.widget.programDialog.donePositiveMessage);
        if (result) {
          this._notificationSenderStore.sendTaskDoneNotification(
              this.widget.program.title, this.widget.task.title);
        }
      });
    } else {
      this.showInformationMessage(this.widget.programDialog.alreadyDoneMessage);
    }
  }
}
