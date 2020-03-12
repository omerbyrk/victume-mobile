import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/utils/screen/ScreenUtils.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
/**
 * Creating custom color palettes is part of creating a custom app. The idea is to create
 * your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
 * object with those colors you just defined.
 *
 * Resource:
 * A good resource would be this website: http://mcg.mbitson.com/
 * You simply need to put in the colour you wish to use, and it will generate all shades
 * for you. Your primary colour will be the `500` value.
 *
 * Colour Creation:
 * In order to create the custom colours you need to create a `Map<int, Color>` object
 * which will have all the shade values. `const Color(0xFF...)` will be how you create
 * the colours. The six character hex code is what follows. If you wanted the colour
 * #114488 or #D39090 as primary colours in your theme, then you would have
 * `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
 *
 * Usage:
 * In order to use this newly created theme or even the colours in it, you would just
 * `import` this file in your project, anywhere you needed it.
 * `import 'path/to/theme.dart';`
 */

import 'package:flutter/material.dart';

ScreenUtils screenUtils = appComponent.getScreenUtils();

final ThemeData themeData = new ThemeData(
    fontFamily: 'DuruSans',
    iconTheme:
        IconThemeData(size: screenUtils.getDeviceIconSize(IconSizeType.Normal)),
    brightness: Brightness.light,
    primarySwatch: MaterialColor(AppColors.purple[500].value, AppColors.purple),
    primaryColor: AppColors.purple[500],
    primaryColorBrightness: Brightness.light,
    textTheme: TextTheme(
        body1: TextStyles.xSmallText.isBolder().ok(),
        button: TextStyles.xSmallText.isBolder().ok()),
    accentColor: AppColors.purple[500],
    accentColorBrightness: Brightness.light);

class AppColors {
  AppColors._(); // this basically makes it so you can instantiate this class

  static const Map<int, Color> purple = const <int, Color>{
    50: const Color(0xFFF4E3F7),
    100: const Color(0xFFE1BAE8),
    200: const Color(0xFFD597E0),
    300: const Color(0xFFC674D5),
    400: const Color(0xFFBA57CB),
    500: const Color(0xFFAB39BF),
    600: const Color(0xFFA02FB4),
    700: const Color(0xFF9C27B0),
    800: const Color(0xFF931EA7),
    900: const Color(0xFF88139C)
  };

  static const Map<int, Color> orange = const <int, Color>{
    50: const Color(0xFFFCE4B0),
    100: const Color(0xFFF6D182),
    200: const Color(0xFFEFC56A),
    300: const Color(0xFFE9BB57),
    400: const Color(0xFFE4B348),
    500: const Color(0xFFDDA939),
    600: const Color(0xFFD9A32F),
    700: const Color(0xFFDCA020),
    800: const Color(0xFFD8980F),
    900: const Color(0xFFD39206)
  };
  static const Map<int, Color> deepOrange = const <int, Color>{
    50: const Color(0xFFFBE9E7),
    100: const Color(0xFFFFCCBC),
    200: const Color(0xFFFFAB91),
    300: const Color(0xFFFF8A65),
    400: const Color(0xFFFF7043),
    500: const Color(0xFFFF5722),
    600: const Color(0xFFF4511E),
    700: const Color(0xFFE64A19),
    800: const Color(0xFFD84315),
    900: const Color(0xFFBF360C),
  };
}
