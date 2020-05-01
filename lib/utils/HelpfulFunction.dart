import 'package:flutter/material.dart';
import 'package:victume_mobile/constants/consts.dart';
import 'package:victume_mobile/data/network/constants/endpoints.dart';

class HelpfulFunction {
  static String toStringAsFixed(dynamic value, {int fixedSupport = 1}) {
    double dValue = double.tryParse(value.toString());
    if (dValue == null) return "0";
    String sValue = dValue.toString();

    if (sValue.contains(".") && int.parse(sValue.split('.')[1]) > 0) {
      return dValue.toStringAsFixed(fixedSupport);
    } else
      return dValue.toStringAsFixed(0);
  }

  static String getFullPhotoPath(String photoPath, String fullname) {
    print(photoPath);
    String placeHolder = "PP";
    if (fullname != null) {
      placeHolder = fullname.split(" ").map((name) => name[0]).join();
    }
    return fullServerImagePath(photoPath,
        placeHolderString: placeHolder.toUpperCase());
  }

  static String fullServerImagePath(String path, {String placeHolderString}) {
    if (path != null)
      return Endpoints.baseUrl + "/" + path;
    else {
      return Consts.imageHolderUrl +
          ((placeHolderString != null) ? "?text=$placeHolderString" : "");
    }
  }

  static String getApiPathWith(String path) {
    return Endpoints.baseUrl + "/" + path;
  }

  static IconData getParameterIcon(String parameterValue) {
    if (parameterValue == null) return Icons.label;

    if (parameterValue.contains("kg")) {
      return Icons.pregnant_woman;
    } else if (parameterValue.contains("cm")) {
      return Icons.accessibility_new;
    } else if (parameterValue.contains("%")) {
      return Icons.beenhere;
    } else {
      return Icons.label;
    }
  }
}
