import 'package:victume_mobile/di/modules/app_module.dart';
import 'package:victume_mobile/di/modules/mobx_module.dart';
import 'package:victume_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inject/inject.dart';
import 'constants/app_theme.dart';
import 'constants/strings.dart';
import 'di/components/app_component.dart';
import 'di/modules/netwok_module.dart';
import 'ui/splash/splash.dart';
import 'package:timeago/timeago.dart' as timeago;

// global instance for app component
// TODO find out a better way to use it across application
AppComponent appComponent;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  timeago.setLocaleMessages("tr", timeago.TrMessages());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    appComponent =
        await AppComponent.create(AppModule(), NetworkModule(), MobxModule());
    runApp(appComponent.app);
  });
}

@provide
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: themeData,
      routes: Routes.routes,
      home: SplashScreen(),
    );
  }
}
