import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/utils/screen/ScreenUtils.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

abstract class ScreenStatelessBase extends StatelessWidget {
  BuildContext context;
  ScreenUtils screenUtils = appComponent.getScreenUtils();

  void setBuildContext(BuildContext context);

  void doDelayedTask(Function function, {Duration duration: Duration.zero}) {
    if (function == null) return;

    Future.delayed(duration, function);
  }

  showErrorMessage(String message) {
    if (message != null) {
      doDelayedTask(() {
        FlushbarHelper.createError(
          message: message,
          title: 'Error',
          duration: Duration(seconds: 3),
        )..show(context);
      });
    }

    return Container();
  }

  Widget navigate(String routerName) {
    doDelayedTask(() {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routerName, (Route<dynamic> route) => false);
    });

    return Container();
  }

  calSizeForDevice(double size) {
    return screenUtils.deviceSizeMultiplier * size;
  }

  calIconSize(IconSizeType type) {
    return screenUtils.getDeviceIconSize(type);
  }

  double calHeight(double percent) => screenHeight * (percent / 100);

  double calWidth(double percent) => screenWidth * (percent / 100);

  double get screenHeight => MediaQuery.of(context).size.height;

  double get screenWidth => MediaQuery.of(context).size.width;
}
