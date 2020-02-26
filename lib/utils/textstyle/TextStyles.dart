import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/utils/screen/ScreenUtils.dart';

import 'TextStyleCreator.dart';

class TextStyles {
  static ScreenUtils _screenUtils = appComponent.getScreenUtils();
  static TextStyleCreator get xSmallText =>
      new TextStyleCreator(fontSize: (9 * _screenUtils.sizeFontMultiplier));
  static TextStyleCreator get smallText =>
      new TextStyleCreator(fontSize: (11 * _screenUtils.sizeFontMultiplier));
  static TextStyleCreator get middleText =>
      new TextStyleCreator(fontSize: (13 * _screenUtils.sizeFontMultiplier));
  static TextStyleCreator get largeText =>
      new TextStyleCreator(fontSize: (15 * _screenUtils.sizeFontMultiplier));
  static TextStyleCreator get xLargeText =>
      new TextStyleCreator(fontSize: (17 * _screenUtils.sizeFontMultiplier));
  static TextStyleCreator get xxLargeText =>
      new TextStyleCreator(fontSize: (19 * _screenUtils.sizeFontMultiplier));

  static TextStyleCreator customText(double fontSize) {
    return new TextStyleCreator(
        fontSize: fontSize * _screenUtils.sizeFontMultiplier);
  }
}
