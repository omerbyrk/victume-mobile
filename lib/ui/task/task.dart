import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/stores/task/task_store.dart';
import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:victume_mobile/ui/task/task_detail.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:victume_mobile/widgets/custom_text_card_rounded.dart';
import 'package:victume_mobile/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  final String programId;
  TaskScreen({Key key, this.programId}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends ScreenStatefulBase<TaskScreen> {
  TaskStore _taskStore = new TaskStore();
  double warningHeight = 0;

  @override
  void initState() {
    super.initState();
    _taskStore.setProgram(this.widget.programId);
    _taskStore.setTaskList(this.widget.programId);
    _taskStore.setProgramDialog(this.widget.programId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._buildAppBar(),
      body: this._buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        elevation: 5.0,
        actions: <Widget>[
          InkWell(
            onTap: () => super.navigatePop(),
            child: Icon(Icons.close,
                color: Colors.white,
                size: this.calIconSize(IconSizeType.Large)),
          ),
          SizedBox(
            width: this.calSizeForDevice(10),
          )
        ],
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Icon(
              Icons.description,
              size: this.calIconSize(IconSizeType.Large),
              color: Colors.white,
            ),
            SizedBox(
              width: this.calSizeForDevice(10.0),
            ),
            Observer(
              builder: (_) {
                return Expanded(
                  child: _taskStore.program != null
                      ? Text(
                          _taskStore.program.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.largeText
                              .whiteColor()
                              .isBolder()
                              .ok(),
                        )
                      : Container(),
                );
              },
            ),
          ],
        ));
  }

  _buildBody() {
    return Provider<TaskStore>(
      create: (_) => _taskStore,
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: this.calSizeForDevice(8),
                  vertical: this.calSizeForDevice(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildSubtitle(),
                  SizedBox(
                    height: this.calSizeForDevice(8),
                  ),
                  _buildTaskWarning(),
                  _buildTaskDetail()
                ],
              ),
            ),
          ),
          _buildIndicator()
        ],
      ),
    );
  }

  _buildIndicator() {
    return Observer(
      builder: (_) {
        return Visibility(
            visible: _taskStore.loading,
            child: CustomProgressIndicatorWidget());
      },
    );
  }

  _buildSubtitle() {
    return Observer(
      builder: (_) {
        if (_taskStore.program == null || _taskStore.program.subtitle == null)
          return Container();

        return CustomRoundedTextCard(
          margin: EdgeInsets.only(
              top: this.calSizeForDevice(8.0),
              left: this.calSizeForDevice(6),
              right: this.calSizeForDevice(6)),
          child: Text(
            _taskStore.program.subtitle,
            style: TextStyles.smallText.blackColor().isBolder().ok(),
            textAlign: TextAlign.justify,
          ),
        );
      },
    );
  }

  _buildTaskWarning() {
    return Observer(
      builder: (_) {
        if (_taskStore.program == null || _taskStore.program.warnings == null)
          return Container();

        return CustomRoundedTextCard(
          backColor: Colors.deepOrange[100],
          borderColor: Colors.deepOrange[200],
          margin: EdgeInsets.only(
              top: this.calSizeForDevice(5.0),
              left: this.calSizeForDevice(6.0),
              right: this.calSizeForDevice(6.0)),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    this.warningHeight =
                        this.warningHeight == 0 ? this.calHeight(40) : 0;
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Dikkat Edilmesi Gerekenler",
                      style: TextStyles.middleText
                          .color(Colors.deepOrange[900])
                          .isBolder()
                          .ok(),
                      textAlign: TextAlign.justify,
                    ),
                    Icon(
                      Icons.details,
                      size: this.calIconSize(IconSizeType.xSmall),
                      color: Colors.deepOrange[900],
                    )
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                height: this.warningHeight,
                curve: Curves.fastOutSlowIn,
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: this.calSizeForDevice(15),
                        ),
                        ...(_taskStore.program.warnings
                            .map((warning) => _buildTaskWarningChild(warning)))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildTaskWarningChild(String warning) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: this.calSizeForDevice(2),
          horizontal: this.calSizeForDevice(8)),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(
                Icons.warning,
                color: Colors.deepOrange[900],
              ),
              SizedBox(
                width: this.calSizeForDevice(16),
              ),
              Expanded(
                  child: Text(
                warning,
                style: TextStyles.smallText
                    .isBolder()
                    .color(Colors.deepOrange[900])
                    .ok(),
                textAlign: TextAlign.justify,
              )),
            ],
          ),
          Divider(
            color: Colors.red[900],
          )
        ],
      ),
    );
  }

  _buildTaskDetail() {
    return Observer(
      builder: (_) {
        if (taskDetailsIsNullOrEmpty || _taskStore.program == null)
          return Container();

        return Column(
          children: <Widget>[
            ...this._taskStore.taskList.map((task) => TaskDetailWidget(
                  task: task,
                  program: _taskStore.program,
                  programDialog: _taskStore.programDialog,
                ))
          ],
        );
      },
    );
  }

  get taskDetailsIsNullOrEmpty =>
      this._taskStore.taskList == null || this._taskStore.taskList.isEmpty;
}
