import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:victume_mobile/data/sharedpref/shared_preference_helper.dart';
import 'package:victume_mobile/utils/screen/ScreenUtils.dart';

@module
class AppModule {
  Future<SharedPreferences> sharedPref;

  AppModule() {
    sharedPref = provideSharedPreferences();
  }

  @provide
  @singleton
  @asynchronous
  Future<SharedPreferences> provideSharedPreferences() =>
      SharedPreferences.getInstance();

  @provide
  @singleton
  SharedPreferenceHelper provideSharedPreferenceHelper() =>
      SharedPreferenceHelper(sharedPref);

  @provide
  @singleton
  ScreenUtils provideScreenUtils() => ScreenUtils();
}
