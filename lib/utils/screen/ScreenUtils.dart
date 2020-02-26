import 'package:victume_mobile/constants/enums.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class ScreenUtils {
  DeviceSizeType deviceSizeType;
  BuildContext context;
  double textScaleFactor = 1.0;

  ScreenUtils() {
    _deviceSizeType();
  }

  Map<DeviceSizeType, double> _deviceSizeRateMultipliers = {
    DeviceSizeType.xSmall: 0.22,
    DeviceSizeType.Small: 0.33,
    DeviceSizeType.Middle: 0.35,
    DeviceSizeType.xMiddle: 0.5,
    DeviceSizeType.Normal: 0.6667,
    DeviceSizeType.Large: 0.83,
    DeviceSizeType.xLarge: 1,
    DeviceSizeType.Ultra: 1.33,
    DeviceSizeType.Mega: 1.58
  };

  Map<DeviceSizeType, double> _deviceFontOrIconSizeRateMultipliers = {
    DeviceSizeType.xSmall: 1,
    DeviceSizeType.Small: 1.03,
    DeviceSizeType.Middle: 1.03,
    DeviceSizeType.xMiddle: 1.07,
    DeviceSizeType.Normal: 1.12,
    DeviceSizeType.Large: 1.15,
    DeviceSizeType.xLarge: 1.18,
    DeviceSizeType.Ultra: 1.21,
    DeviceSizeType.Mega: 1.25
  };

  Map<IconSizeType, double> _deviceIconSizes = {
    IconSizeType.xSmall: 20,
    IconSizeType.Small: 22,
    IconSizeType.Normal: 24,
    IconSizeType.Large: 26,
    IconSizeType.xLarge: 28,
    IconSizeType.xxLarge: 30,
    IconSizeType.Mega: 35,
    IconSizeType.xMega: 40,
    IconSizeType.xxMega: 50
  };

  init(BuildContext context) {
    this.context = context;
    this.textScaleFactor = MediaQuery.of(context).textScaleFactor;
  }

  _deviceSizeType() {
    double width = window.physicalSize.width;
    double height = window.physicalSize.height;

    print(width.toString() + " * " + height.toString());
    if (width <= 240) {
      deviceSizeType = DeviceSizeType.xSmall;
    } else if (width <= 360) {
      deviceSizeType = DeviceSizeType.Small;
    } else if (width <= 480) {
      deviceSizeType = DeviceSizeType.Middle;
    } else if (width <= 540) {
      deviceSizeType = DeviceSizeType.xMiddle;
    } else if (width <= 720) {
      deviceSizeType = DeviceSizeType.Normal;
    } else if (width <= 900) {
      deviceSizeType = DeviceSizeType.Large;
    } else if (width <= 1080) {
      deviceSizeType = DeviceSizeType.xLarge;
    } else if (width <= 1440) {
      deviceSizeType = DeviceSizeType.Ultra;
    } else {
      deviceSizeType = DeviceSizeType.Mega;
    }
    print(width.toString() + " " + deviceSizeType.toString());
  }

  get sizeFontMultiplier {
    if (deviceSizeType == null) {
      deviceSizeType = DeviceSizeType.Normal;
    }
    return textScaleFactor *
        _deviceFontOrIconSizeRateMultipliers[deviceSizeType];
  }

  get deviceSizeMultiplier {
    if (deviceSizeType == null) {
      deviceSizeType = DeviceSizeType.Normal;
    }
    return _deviceSizeRateMultipliers[deviceSizeType];
  }

  double getDeviceIconSize(IconSizeType type) {
    return _deviceIconSizes[type] * _deviceFontOrIconSizeRateMultipliers[deviceSizeType];
  }
}
