import 'package:victume_mobile/data/AchievementApi.dart';
import 'package:victume_mobile/data/MessageApi.dart';
import 'package:victume_mobile/data/MessageContainerApi.dart';
import 'package:victume_mobile/data/NotificationUserApi.dart';
import 'package:victume_mobile/data/ParameterApi.dart';
import 'package:victume_mobile/data/ParameterValueApi.dart';
import 'package:victume_mobile/data/ProfileApi.dart';
import 'package:victume_mobile/data/ProgramApi.dart';
import 'package:victume_mobile/data/ProgramDialogApi.dart';
import 'package:victume_mobile/data/TaskAlarmApi.dart';
import 'package:victume_mobile/data/TaskApi.dart';
import 'package:victume_mobile/data/TaskResultApi.dart';
import 'package:victume_mobile/data/UserApi.dart';
import 'package:victume_mobile/data/UserFileApi.dart';
import 'package:victume_mobile/data/UserProgramApi.dart';
import 'package:victume_mobile/data/sharedpref/shared_preference_helper.dart';
import 'package:victume_mobile/di/modules/app_module.dart';
import 'package:victume_mobile/di/modules/mobx_module.dart';
import 'package:victume_mobile/di/modules/netwok_module.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/stores/notification/notification_sender.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_message_store.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';
import 'package:victume_mobile/utils/screen/ScreenUtils.dart';
import 'package:inject/inject.dart';

import 'app_component.inject.dart' as g;

/// The top level injector that stitches together multiple app features into
/// a complete app.
@Injector(const [AppModule, NetworkModule, MobxModule])
abstract class AppComponent {
  @provide
  MyApp get app;

  static Future<AppComponent> create(
    AppModule appModule,
    NetworkModule networkModule,
    MobxModule mobxModule,
  ) async {
    return await g.AppComponent$Injector.create(
        appModule, networkModule, mobxModule);
  }

  // repositories
  @provide
  UserApi getUserApi();
  @provide
  ParameterApi getParameterApi();
  @provide
  UserProgramApi getUserProgramApi();
  @provide
  TaskApi getTaskApi();
  @provide
  ProgramApi getProgramApi();
  @provide
  TaskAlarmApi getTaskAlarmApi();
  @provide
  TaskResultApi getTaskResultApi();
  @provide
  ProgramDialogApi getProgramDialogApi();
  @provide
  ProfileApi getProfileApi();
  @provide
  AchievementApi getAchievementApi();
  @provide
  NotificationUserApi getNotificationUserApi();
  @provide
  ParameterValueApi getParameterValueApi();
  @provide
  UserFileApi getUserFileApi();
  @provide
  MessageContainerApi getMessageContainerApi();
  @provide
  MessageApi getMessageApi();

  // locale - mobx
  @provide
  SharedPreferenceHelper getSharedPreferenceHelper();
  @provide
  UserProfileStore getUserProfileStore();
  @provide
  UserProfileMessageStore getUserProfileMessageStore();
  @provide
  NotificationSenderStore getNotificationSenderStore();
  @provide
  ScreenUtils getScreenUtils();
}
