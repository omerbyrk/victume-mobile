import 'package:victume_mobile/constants/app_theme.dart';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/models/api/UserProgramView.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';
import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:victume_mobile/ui/task/task.dart';
import 'package:victume_mobile/utils/task/taskutils.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UserProfileBottomWidget extends StatefulWidget {
  UserProfileBottomWidget({Key key}) : super(key: key);

  @override
  _UserProfileBottomWidgetState createState() =>
      _UserProfileBottomWidgetState();
}

class _UserProfileBottomWidgetState
    extends ScreenStatefulBase<UserProfileBottomWidget> {
  UserProfileStore _userProfileStore = appComponent.getUserProfileStore();
  TaskUtils _taskUtils = TaskUtils();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBottomBody();
  }

  Widget _buildBottomBody() {
    return Flexible(
      fit: FlexFit.tight,
      child: Column(
        children: <Widget>[
          _buildBottomBodyHeader(),
          Divider(
            color: AppColors.green[500].withOpacity(.7),
            thickness: 1.2,
          ),
          _buildBottomBodyContent()
        ],
      ),
    );
  }

  Widget _buildBottomBodyHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: this.calSizeForDevice(3.0), horizontal: this.calSizeForDevice(12.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.done_all,
                size: this.calIconSize(IconSizeType.xLarge),
              ),
              SizedBox(
                width: this.calSizeForDevice(8.0),
              ),
              Text(
                "Programlar",
                style: TextStyles.xLargeText.isBolder().ok(),
              )
            ],
          ),
          InkWell(
            onTap: () {
              this._userProfileStore.setAuthUserPrograms(
                  limit: _userProfileStore.authUserProgramDataCount * 2);
            },
            child: Observer(
              builder: (_) => Text(
                "HEPSİ(${_userProfileStore.authUserProgramDataCount})",
                style: TextStyles.middleText
                    .isBolder()
                    .color(AppColors.green[700])
                    .ok(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomBodyContent() {
    return Observer(
      builder: (_) => _userProfileStore.authUserPrograms.length != 0
          ? Expanded(
              child: ListView.separated(
                padding:  EdgeInsets.symmetric(horizontal: this.calSizeForDevice(5)),
                primary: false,
                shrinkWrap: true,
                itemCount: _userProfileStore.authUserPrograms.length,
                itemBuilder: (BuildContext context, int index) {
                  UserProgramView userProgram =
                      _userProfileStore.authUserPrograms[index];
                  String subtitle = _taskUtils.getTaskDateAsString(userProgram);
                  return ListTile(
                    title: Text(
                      userProgram.program.title,
                      style: TextStyles.largeText.isBolder().ok(),
                    ),
                    subtitle: Text(
                      subtitle,
                      style: TextStyles.smallText.isBolder().ok(),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => TaskScreen(
                                programId: userProgram.program.id,
                              )));
                    },
                    trailing: Icon(
                      Icons.navigate_next,
                      size: this.calIconSize(IconSizeType.xxLarge),
                      color: AppColors.green[500],
                    ),
                    dense: true,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.green,
                ),
              ),
            )
          : Container(),
    );
  }
}
