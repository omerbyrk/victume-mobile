import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/stores/base_store.dart';
import 'package:victume_mobile/stores/ui_message/ui_message_store.dart';
import 'package:victume_mobile/utils/screen/ScreenUtils.dart';
import 'package:victume_mobile/widgets/custom_dialog.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:victume_mobile/widgets/progress_indicator_widget.dart';

abstract class ScreenStatefulBase<T extends StatefulWidget> extends State<T> {
  ScreenUtils screenUtils = appComponent.getScreenUtils();
  void doDelayedTask(Function function, {Duration duration: Duration.zero}) {
    if (function == null) return;

    Future.delayed(duration, function);
  }

  showErrorMessage(String message) {
    if (message != null) {
      doDelayedTask(() {
        FlushbarHelper.createError(
          message: message,
          title: 'Heyyy!',
          duration: Duration(seconds: 3),
        )..show(context);
      });
    }
    return Container();
  }

  showInformationMessage(String message) {
    if (message != null) {
      doDelayedTask(() {
        FlushbarHelper.createInformation(
          message: message,
          title: 'Bilgilendirme',
          duration: Duration(seconds: 3),
        )..show(context);
      });
    }
    return Container();
  }

  showSuccessMessage(String message) {
    if (message != null) {
      doDelayedTask(() {
        FlushbarHelper.createSuccess(
          message: message,
          title: 'Yeapp! :)',
          duration: Duration(seconds: 3),
        )..show(context);
      });
    }
    return Container();
  }

  Widget showMessage(String message, MESSAGE_TYPE type) {
    switch (type) {
      case MESSAGE_TYPE.SUCCESS:
        return showSuccessMessage(message);
      case MESSAGE_TYPE.ERROR:
        return showErrorMessage(message);
      case MESSAGE_TYPE.INFO:
        return showInformationMessage(message);
      default:
        return Container();
    }
  }

  showAlertDialog(String title, String description,
      {Function onAcceptAction, Function onRejectAction}) {
    return showDialog(
        context: context,
        builder: (_) {
          return CustomDialog(
            title: title,
            description: description,
            onAcceptAction: onAcceptAction,
            onRejectAction: onRejectAction,
          );
        });
  }

  Widget buildUIMessageHandler(BaseStore store) {
    return Observer(
      builder: (_) {
        Widget result = store.uiMessageStore.showMessage
            ? showMessage(
                store.uiMessageStore.message, store.uiMessageStore.type)
            : Container();
        doDelayedTask(() => store.uiMessageStore.clear());
        return result;
      },
    );
  }

  Widget buildIndicator(BaseStore store) {
    return Observer(
      builder: (_) {
        return Visibility(
            visible: store.loading, child: CustomProgressIndicatorWidget());
      },
    );
  }

  navigatePush(Function(BuildContext) builder) {
    doDelayedTask(
        () => Navigator.of(context).push(MaterialPageRoute(builder: builder)));
  }

  navigatePop() {
    doDelayedTask(() => Navigator.of(context).pop());
  }

  double calSizeForDevice(double size) {
    return screenUtils.deviceSizeMultiplier * size;
  }

  double calIconSize(IconSizeType type) {
    return screenUtils.getDeviceIconSize(type);
  }

  Widget navigate(String routerName) {
    doDelayedTask(() {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routerName, (Route<dynamic> route) => false);
    });

    return Container();
  }

  double calHeight(double percent) => screenHeight * (percent / 100);

  double calWidth(double percent) => screenWidth * (percent / 100);

  double get screenHeight => MediaQuery.of(context).size.height;

  double get screenWidth => MediaQuery.of(context).size.width;
}
