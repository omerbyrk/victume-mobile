import 'package:victume_mobile/ui/ScreenStatelessBase.dart';
import 'package:flutter/material.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';

class BadgettedIcon extends ScreenStatelessBase {
  final int number;
  final IconData iconData;
  final Color color;
  final double size;

  BadgettedIcon({Key key, this.number, this.iconData, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    this.setBuildContext(context);
    return Stack(
      children: <Widget>[
        Icon(
          iconData,
          size: size,
          color: color,
        ),
        number != 0
            ? Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '$number',
                    style: TextStyles.customText(9).whiteColor().ok(),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Positioned.fill(
                child: Container(),
              )
      ],
    );
  }

  @override
  void setBuildContext(BuildContext context) {
    this.context = context;
  }
}

/* */
