import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/models/widget/CustomMenuButtonItem.dart';
import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatefulWidget {
  final List<CustomPopupMenuItem> customPopupMenuItems;
  final Color color;
  final double size;
  final Function(dynamic) onAction;

  CustomPopupMenuButton(
      {this.customPopupMenuItems, this.color, this.size, this.onAction});

  @override
  _CustomPopupMenuButtonState createState() => _CustomPopupMenuButtonState();
}

class _CustomPopupMenuButtonState
    extends ScreenStatefulBase<CustomPopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: this.widget.onAction,
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
        size: this.calIconSize(IconSizeType.Large),
      ),
      elevation: 5.0,
      itemBuilder: (_) {
        return this
            .widget
            .customPopupMenuItems
            .map((customPopupMenuItem) => PopupMenuItem(
                  value: customPopupMenuItem.value,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        customPopupMenuItem.icon,
                        color: this.widget.color,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(customPopupMenuItem.label,
                          style: TextStyles.middleText
                              .color(this.widget.color)
                              .ok())
                    ],
                  ),
                ))
            .toList();
      },
    );
  }
}
