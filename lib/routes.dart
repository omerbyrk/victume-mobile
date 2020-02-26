import 'package:victume_mobile/ui/user_profile/user_profile.dart';
import 'package:flutter/material.dart';

import 'ui/login/login.dart';
import 'ui/splash/splash.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/user-home';
  static const String todo = '/todo';
  static const String taskDetails = "/taskdetails";

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => UserProfileScreen(),
  };
}



