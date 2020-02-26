import 'package:victume_mobile/constants/app_theme.dart';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/models/widget/CustomMenuButtonItem.dart';
import 'package:victume_mobile/routes.dart';
import 'package:victume_mobile/stores/login/login_store.dart';
import 'package:victume_mobile/stores/notification/notification_sender.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';
import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:victume_mobile/ui/achievement/achievement_list.dart';
import 'package:victume_mobile/ui/measurement/measurement_list.dart';
import 'package:victume_mobile/ui/message/message.dart';
import 'package:victume_mobile/ui/user_profile/user_profile_bottom.dart';
import 'package:victume_mobile/ui/user_profile/user_profile_notifications.dart';
import 'package:victume_mobile/ui/user_profile/user_profile_top.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:victume_mobile/widgets/badgetted_icon.dart';
import 'package:victume_mobile/widgets/custom_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ScreenStatefulBase<UserProfileScreen> {
  final UserProfileStore _userProfileStore = appComponent.getUserProfileStore();
  final NotificationSenderStore _notificationSenderStore =
      appComponent.getNotificationSenderStore();

  @override
  void initState() {
    super.initState();
    this._userProfileStore.clearStore();
    this._userProfileStore.setAuthUser();
    this._userProfileStore.setAuthUserParameters();
    this._userProfileStore.setAuthUserPrograms();
    this._userProfileStore.setAuthUserNotifications();

    this.doDelayedTask(
        () => {
              if (this._userProfileStore.authUserParameters.length == 0)
                {
                  this
                      ._notificationSenderStore
                      .sendParameterNotFoundNotification()
                }
            },
        duration: Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody());
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.green[600],
      elevation: 0,
      title: Row(
        children: <Widget>[
          Icon(
            Icons.home,
            size: this.calIconSize(IconSizeType.Large),
            color: Colors.white,
          ),
          SizedBox(
            width: this.calSizeForDevice(8),
          ),
          Observer(
            builder: (_) {
              return _userProfileStore.authenticatedUser?.institution != null
                  ? Expanded(
                      child: Text(
                        _userProfileStore.authenticatedUser?.institution?.name,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyles.largeText.isBolder().whiteColor().ok(),
                      ),
                    )
                  : Container();
            },
          )
        ],
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            InkWell(
              splashColor: Colors.red.withOpacity(.9),
              child: BadgettedIcon(
                  iconData: Icons.message,
                  size: calIconSize(IconSizeType.Large),
                  number: 0,
                  color: Colors.white),
              onTap: () {
                navigatePush((_) => MessageScreen());
              },
            ),
            SizedBox(
              width: this.calSizeForDevice(7.5),
            ),
            InkWell(
              splashColor: Colors.red.withOpacity(.9),
              child: Observer(builder: (_) {
                return BadgettedIcon(
                    iconData: Icons.notifications,
                    number: this
                            ._userProfileStore
                            ?.authUserNotifications
                            ?.unReadNotifications ??
                        0,
                    size: calIconSize(IconSizeType.Large),
                    color: Colors.white);
              }),
              onTap: () {
                this._userProfileStore.showNotifications =
                    !this._userProfileStore.showNotifications;
              },
            ),
            SizedBox(
              width: this.calSizeForDevice(7.5),
            ),
            CustomPopupMenuButton(
              onAction: (value) {
                if (value == CustomMenuItemValue.Logout) {
                  this._userProfileStore.clearStore();
                  LoginStore().logout();
                  navigate(Routes.splash);
                } else if (value == CustomMenuItemValue.AchievementList) {
                  navigatePush((_) => AchievementListScreen());
                } else if (value == CustomMenuItemValue.MeasurementList) {
                  navigatePush((_) => MeasurementListScreen());
                }
              },
              customPopupMenuItems: <CustomPopupMenuItem>[
                CustomPopupMenuItem(
                    icon: Icons.stars,
                    label: "Hedeflerim",
                    value: CustomMenuItemValue.AchievementList),
                CustomPopupMenuItem(
                    icon: Icons.image,
                    label: "Ölçümlerim",
                    value: CustomMenuItemValue.MeasurementList),
                CustomPopupMenuItem(
                    icon: Icons.close,
                    label: "Çıkıs Yap",
                    value: CustomMenuItemValue.Logout)
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            UserProfileTopWidget(),
            UserProfileBottomWidget(),
          ],
        ),
        super.buildIndicator(_userProfileStore),
        super.buildUIMessageHandler(_userProfileStore),
        _buildUserProfileNotificationLayer(),
        _buildUserProfileNotification(),
      ],
    );
  }

  _buildUserProfileNotification() {
    return Observer(
      builder: (_) {
        return !_userProfileStore.showNotifications
            ? Container()
            : Positioned(
                right: 0,
                top: 0,
                child: Container(
                    height: this.calHeight(80),
                    width: this.calWidth(80),
                    child: UserProfileNotifications()),
              );
      },
    );
  }

  _buildUserProfileNotificationLayer() {
    return Observer(builder: (_) {
      return this._userProfileStore.showNotifications
          ? Positioned.fill(
              child: InkWell(
              onTap: () {
                this._userProfileStore.showNotifications = false;
              },
              child: Opacity(
                  opacity: .5,
                  child: Container(
                    color: Colors.black,
                  )),
            ))
          : Container();
    });
  }
}
