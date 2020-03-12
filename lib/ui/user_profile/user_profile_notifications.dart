import 'package:mobx/mobx.dart';
import 'package:victume_mobile/constants/app_theme.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/models/api/NotificationUser.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';
import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:victume_mobile/utils/HelpfulFunction.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UserProfileNotifications extends StatefulWidget {
  @override
  _UserProfileNotificationsState createState() =>
      _UserProfileNotificationsState();
}

class _UserProfileNotificationsState
    extends ScreenStatefulBase<UserProfileNotifications> {
  UserProfileStore _userProfileStore = appComponent.getUserProfileStore();
  ScrollController scrollController = new ScrollController();
  ReactionDisposer showNotificationDisposer;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (_userProfileStore?.authUserNotifications?.notifications?.length !=
            _userProfileStore?.authUserNotifications?.totalNotifications) {
          _userProfileStore.setAuthUserNotifications(
              limit: (_userProfileStore
                          ?.authUserNotifications?.notifications?.length ??
                      0) +
                  5);
        }
      }
    });
    showNotificationDisposer = autorun((_) {
      if (!this._userProfileStore.showNotifications &&
          this._userProfileStore.authUserNotifications.unReadNotifications >
              0) {
        this._userProfileStore.setReaddedAllAuthUserNotifications();
      }
    });
  }

  @override
  void dispose() {
    showNotificationDisposer.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      color: AppColors.purple[50],
      child: Stack(
        children: <Widget>[_buildBody()],
      ),
    );
  }

  _buildBody() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildBodyContent(),
        ],
      ),
    );
  }

  _buildBodyContent() {
    return Expanded(child: Observer(builder: (_) {
      return ListView.builder(
          controller: scrollController,
          itemCount:
              _userProfileStore.authUserNotifications.notifications.length,
          itemBuilder: (_, index) {
            NotificationUser notification =
                _userProfileStore.authUserNotifications.notifications[index];
            _userProfileStore.setNotificationImage(notification.id);
            return Container(
              color: !notification.isRead
                  ? AppColors.purple[300]
                  : Colors.transparent,
              padding: EdgeInsets.symmetric(
                  horizontal: this.calSizeForDevice(12.0),
                  vertical: this.calSizeForDevice(16.0)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Material(
                    elevation: 18,
                    clipBehavior: Clip.antiAlias,
                    shape: CircleBorder(),
                    child: Observer(builder: (_) {
                      return Image.network(
                        HelpfulFunction.getFullPhotoPath(
                            _userProfileStore.loaddedNotificationImages
                                    .containsKey(notification.id)
                                ? _userProfileStore
                                    .loaddedNotificationImages[notification.id]
                                : null,
                            "N"),
                        height: 50,
                        width: 50,
                        color: AppColors.purple[600].withOpacity(.15),
                        colorBlendMode: BlendMode.color,
                        fit: BoxFit.cover,
                      );
                    }),
                  ),
                  SizedBox(
                    width: this.calSizeForDevice(10.0),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        notification.content,
                        style: TextStyles.middleText
                            .color(!notification.isRead
                                ? Colors.blueGrey[800]
                                : Colors.black87)
                            .ok(),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ))
                ],
              ),
            );
          });
    }));
  }
}
