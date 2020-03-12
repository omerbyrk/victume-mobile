import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:victume_mobile/constants/app_theme.dart';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/models/api/AchievementView.dart';
import 'package:victume_mobile/stores/achievement/achievement_list_store.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';
import 'package:victume_mobile/ui/ScreenStatelessBase.dart';
import 'package:victume_mobile/utils/HelpfulFunction.dart';
import 'package:victume_mobile/utils/TimeAgoHelper.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:intl/intl.dart';
import 'package:victume_mobile/widgets/custom_text_card_rounded.dart';

class AchievementCard extends ScreenStatelessBase {
  AchievementView achievementView;
  Function(AchievementView) onDeleteButtonAction;
  Function(AchievementView) onResultToggleButtonAction;
  AchievementListStore _achievementListStore;
  UserProfileStore _userProfileStore = appComponent.getUserProfileStore();

  AchievementCard(
      {this.achievementView,
      this.onDeleteButtonAction,
      this.onResultToggleButtonAction});

  @override
  Widget build(BuildContext context) {
    this.setBuildContext(context);
    _achievementListStore =
        Provider.of<AchievementListStore>(context, listen: false);
    return Stack(
      children: <Widget>[
        CustomRoundedTextCard(
          margin: EdgeInsets.all(this.calSizeForDevice(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildCardTitle(achievementView),
              Divider(),
              _buildCardContent(achievementView),
              Divider(),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  TimeAgoHelper.timeAgo(achievementView.targetDate),
                  style: TextStyles.xSmallText.isBolder().ok(),
                ),
              )
            ],
          ),
        ),
        this._buildResultToggleIcon(achievementView),
        this._buildDeleteIcon(achievementView),
        this._buildDoneLayer(achievementView),
        this._buildDoneLayoutItem(achievementView)
      ],
    );
  }

  Row _buildCardContent(AchievementView achievementView) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildValueAndDateChipColumn(
            achievementView.currentValue,
            achievementView.createdDate,
            Colors.red[300],
            CrossAxisAlignment.start),
        _buildTargetArrowIcon(),
        _buildValueAndDateChipColumn(
            achievementView.targetValue,
            achievementView.targetDate,
            Colors.green[300],
            CrossAxisAlignment.end)
      ],
    );
  }

  Row _buildCardTitle(AchievementView achievementView) {
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Icon(
        Icons.star_border,
        size: this.calIconSize(IconSizeType.Small),
      ),
      SizedBox(
        width: this.calSizeForDevice(5),
      ),
      Text(
        achievementView.parameterName,
        style: TextStyles.xLargeText.isBolder().ok(),
      ),
    ]);
  }

  Expanded _buildTargetArrowIcon() {
    return Expanded(
        child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.center,
                colors: [
                  Colors.red[900],
                  Colors.green[300],
                ],
              ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height));
            },
            child: Icon(
              Icons.forward,
              size: this.calIconSize(IconSizeType.xxMega),
            )));
  }

  Column _buildValueAndDateChipColumn(
      String value, DateTime date, Color color, CrossAxisAlignment alignment) {
    return Column(
      crossAxisAlignment: alignment,
      children: <Widget>[
        Chip(
            backgroundColor: color,
            labelPadding:
                EdgeInsets.symmetric(horizontal: this.calSizeForDevice(8)),
            avatar: Icon(HelpfulFunction.getParameterIcon(value),
                size: this.calIconSize(IconSizeType.xSmall)),
            label: Text(
              value,
              style: TextStyles.middleText.isBolder().ok(),
            )),
        Chip(
            backgroundColor: color,
            labelPadding:
                EdgeInsets.symmetric(horizontal: this.calSizeForDevice(8)),
            avatar: Icon(Icons.date_range,
                size: this.calIconSize(IconSizeType.xSmall)),
            label: Text(DateFormat("dd/MM/yyyy").format(date),
                style: TextStyles.middleText.isBolder().ok()))
      ],
    );
  }

  Widget _buildResultToggleIcon(AchievementView achievementView) {
    if (achievementView.result) return Container();

    return Positioned(
        top: -8,
        right: 15,
        child: InkWell(
          onTap: () => this.onResultToggleButtonAction(achievementView),
          child: Icon(
            Icons.done_all,
            color: Colors.green[600],
            size: this.calIconSize(IconSizeType.xMega),
          ),
        ));
  }

  Widget _buildDeleteIcon(AchievementView achievementView) {
    if (achievementView.result) return Container();

    return Positioned(
        top: -8,
        left: 15,
        child: InkWell(
          onTap: () => this.onDeleteButtonAction(achievementView),
          child: Icon(
            Icons.delete,
            color: Colors.red[600],
            size: this.calIconSize(IconSizeType.xMega),
          ),
        ));
  }

  Widget _buildDoneLayer(AchievementView achievementView) {
    if (!achievementView.result || _achievementListStore.showCongratulations)
      return Container();

    return Positioned.fill(
      child: Opacity(
        opacity: .7,
        child: Container(
          margin: EdgeInsets.all(this.calSizeForDevice(10)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildDoneLayoutItem(AchievementView achievementView) {
    if (!achievementView.result || _achievementListStore.showCongratulations)
      return Container();

    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.done,
                size: this.calIconSize(IconSizeType.Large),
                color: Colors.white,
              ),
              SizedBox(
                width: this.calSizeForDevice(10),
              ),
              Text(
                "Tamamlandı",
                style: TextStyles.xLargeText.whiteColor().isBolder().ok(),
              ),
            ],
          ),
          SizedBox(
            height: this.calSizeForDevice(20),
          ),
          achievementView.resultParameterValueId ==
                      _userProfileStore
                          .findFromAuthUserParamsBy(achievementView.parameterId)
                          .parameterValue
                          .id &&
                  !_achievementListStore.achievementList.any((ach) =>
                      ach.parameterId == achievementView.parameterId &&
                      !ach.result)
              ? OutlineButton.icon(
                  onPressed: () => onResultToggleButtonAction(achievementView),
                  icon: Icon(Icons.restore),
                  label: Text("Geri Al"),
                  textColor: Colors.white,
                  borderSide: BorderSide(color: Colors.white),
                  color: Colors.white)
              : Container()
        ],
      ),
    );
  }

  @override
  void setBuildContext(BuildContext context) {
    this.context = context;
  }
}
