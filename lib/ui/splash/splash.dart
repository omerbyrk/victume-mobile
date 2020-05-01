import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:victume_mobile/constants/consts.dart';
import 'package:victume_mobile/data/UserApi.dart';
import 'package:victume_mobile/data/sharedpref/shared_preference_helper.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/routes.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_message_store.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';
import 'package:victume_mobile/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferenceHelper _helper = appComponent.getSharedPreferenceHelper();
  UserProfileStore _userProfileStore = appComponent.getUserProfileStore();
  UserProfileMessageStore _messageStore =
      appComponent.getUserProfileMessageStore();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  UserApi _userApi = appComponent.getUserApi();
  @override
  void initState() {
    super.initState();
    Function cofigureFunction = (Map<String, dynamic> message) async {
      if (message["data"]["type"] == "NOTIFICATION") {
        fetchAllAuthNotificationIfLoggedIn();
      } else if (message["data"]["type"] == "MESSAGE") {
        _messageStore
            .pushMessageToMentorContainerBy(message["data"]["messageId"]);
      }
    };
    _firebaseMessaging.configure(
        onMessage: cofigureFunction,
        onLaunch: cofigureFunction,
        onResume: cofigureFunction);
    fcmUserTokenControl();
  }

  void fetchAllAuthNotificationIfLoggedIn() async {
    if (await _helper.isLoggedIn) {
      _userProfileStore.setAuthUserNotifications();
    }
  }

  Future<void> deleteFcmUserTokenIfRequired() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    if (_preferences.containsKey(Consts.fcmTokenSettingDateKey)) {
      DateTime fcmTokenSettingDate = DateTime.tryParse(
          _preferences.getString(Consts.fcmTokenSettingDateKey));
      if (DateTime.now().difference(fcmTokenSettingDate).inDays > 1) {
        _preferences.remove(Consts.fcmTokenKey);
        _preferences.remove(Consts.fcmTokenSettingDateKey);
      }
    }
  }

  void fcmUserTokenControl() async {
    await deleteFcmUserTokenIfRequired();
    if (await _helper.isLoggedIn) {
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      if (!_preferences.containsKey(Consts.fcmTokenKey)) {
        String fcmToken = await _firebaseMessaging.getToken();
        bool apiResult = await _userApi.setAuthUserFcmToken(fcmToken);
        if (apiResult) {
          _preferences.setString(Consts.fcmTokenKey, fcmToken);
          _preferences.setString(
              Consts.fcmTokenSettingDateKey, DateTime.now().toString());
          startNavigateTimer(milliseconds: 1000);
          return;
        }
      }
    }
    startNavigateTimer();
  }

  @override
  Widget build(BuildContext context) {
    appComponent.getScreenUtils().init(context);
    return Material(
      child: Center(child: AppIconWidget(image: 'assets/icons/logo.png')),
    );
  }

  startNavigateTimer({milliseconds: 3000}) {
    var _duration = Duration(milliseconds: milliseconds);
    return Timer(_duration, navigate);
  }

  navigate() async {
    if (await _helper.isLoggedIn) {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}
