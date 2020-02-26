import 'package:victume_mobile/constants/app_theme.dart';
import 'package:flutter/material.dart';

class TextStyleCreator {
  Color _color;
  FontWeight _fontWeight;
  double _fontSize;
  TextDecoration _textDecoration;
  TextStyleCreator({double fontSize}) {
    _fontSize = fontSize;
  }

  TextStyleCreator color(Color color) {
    this._color = color;
    return this;
  }

  TextStyleCreator blackColor() {
    this._color = Colors.black;
    return this;
  }

  TextStyleCreator primaryColor() {
    _color = themeData.primaryColor;
    return this;
  }

  TextStyleCreator whiteColor() {
    _color = Colors.white;
    return this;
  }

  TextStyleCreator isBolder() {
    _fontWeight = FontWeight.bold;
    return this;
  }

  TextStyleCreator withOpacity(double opacity) {
    if (this._color == null) throw Exception("Color value is null!");

    this._color = this._color.withOpacity(opacity);

    return this;
  }

  TextStyleCreator weigth(FontWeight weigth) {
    this._fontWeight = weigth;
    return this;
  }

  TextStyleCreator isLineThrough() {
    this._textDecoration = TextDecoration.lineThrough;
    return this;
  }

  TextStyleCreator isW400() {
    return this.weigth(FontWeight.w400);
  }

    TextStyleCreator isW500() {
    return this.weigth(FontWeight.w500);
  }

  TextStyle ok() {
    return TextStyle(
        fontSize: this._fontSize,
        color: this._color,
        fontWeight: this._fontWeight,
        decoration: this._textDecoration,
        );
  }
}
