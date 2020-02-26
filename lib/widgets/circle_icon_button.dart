import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:flutter/material.dart';

class CircleIconButton extends StatefulWidget {
  final Function onPressed;
  final Gradient gradient;
  final Color iconColor;
  final double iconSize;
  final IconData iconData;

  CircleIconButton(
      {this.onPressed,
      this.gradient,
      this.iconColor,
      this.iconData,
      this.iconSize: 30});

  @override
  _CircleIconButtonState createState() => _CircleIconButtonState();
}

class _CircleIconButtonState extends ScreenStatefulBase<CircleIconButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      elevation: 5.0,
      child: Container(
        child: Ink(
          decoration: ShapeDecoration(
              gradient: this.widget.gradient, shape: CircleBorder()),
          child: IconButton(
            padding: EdgeInsets.all(15),
            iconSize: this.calSizeForDevice(this.widget.iconSize),
            icon: Icon(
              this.widget.iconData,
            ),
            color: this.widget.iconColor,
            onPressed: this.widget.onPressed,
          ),
        ),
      ),
    );
  }
}
