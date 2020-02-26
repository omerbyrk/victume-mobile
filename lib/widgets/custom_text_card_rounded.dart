import 'package:flutter/material.dart';

class CustomRoundedTextCard extends StatelessWidget {
  final Widget child;
  final Color backColor;
  final Color borderColor;
  final double elevation;
  final EdgeInsets margin;
  final EdgeInsets padding;
  const CustomRoundedTextCard(
      {Key key,
      this.child,
      this.backColor: Colors.white70,
      this.borderColor: Colors.black26,
      this.elevation: 5.0,
      this.margin,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: this.margin ?? EdgeInsets.only(top: 16, left: 6, right: 6),
      elevation: this.elevation,
      color: this.backColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: this.borderColor, width: 1.0),
          borderRadius: BorderRadius.circular(12)),
      child: Container(
          padding: this.padding ??
              EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: this.child),
    );
  }
}
