import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/ui/ScreenStatelessBase.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:flutter/material.dart';

class CustomRoundedChip extends ScreenStatelessBase {
  String content;
  IconData iconData;
  Color color;
  CustomRoundedChip(
      {Key key, this.iconData, this.color: Colors.white, this.content});

  @override
  Widget build(BuildContext context) {
    this.setBuildContext(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.3),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.iconData,
            color: color,

          size: this.calIconSize(IconSizeType.Small),
          ),
          SizedBox(
            width: 7,
          ),
          Expanded(
            child: Text(
              this.content,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.smallText.isBolder().color(this.color).ok(),
            ),
          )
        ],
      ),
    );
  }

  @override
  void setBuildContext(BuildContext context) {
    // TODO: implement setBuildContext
  }
}
