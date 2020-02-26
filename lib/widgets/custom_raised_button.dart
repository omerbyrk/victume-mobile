import 'package:flutter/material.dart';

class CustomRaisedButton extends StatefulWidget {
  final Gradient gradient;
  final Icon icon;
  final Text text;
  final Function onPressed;

  CustomRaisedButton(
      {this.icon, this.text, this.gradient, @required this.onPressed});

  @override
  _CustomRaisedButtonState createState() => _CustomRaisedButtonState();
}

class _CustomRaisedButtonState extends State<CustomRaisedButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: StadiumBorder(),
      onPressed: this.widget.onPressed,
      padding: const EdgeInsets.all(0.0),
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
        decoration: BoxDecoration(
            gradient: this.widget.gradient,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadiusDirectional.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            this.widget.icon,
            SizedBox(
              width: 5,
            ),
            this.widget.text
          ],
        ),
      ),
    );
  }
}
