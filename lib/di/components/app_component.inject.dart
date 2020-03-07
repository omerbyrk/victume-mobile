import 'app_component.dart' as _i1;
import '../modules/netwok_module.dart' as _i2;
import '../modules/app_module.dart' as _i3;
import '../../data/sharedpref/shared_preference_helper.dart' as _i4;
import '../modules/mobx_module.dart' as _i5;
import '../../stores/user_profile/user_profile_store.dart' as _i6;
import '../../stores/user_profile/user_profile_message_store.dart' as _i7;
import '../../stores/notification/notification_sender.dart' as _i8;
import '../../utils/screen/ScreenUtils.dart' as _i9;
import 'dart:async' as _i10;
import '../../main.dart' as _i11;
import '../../data/UserApi.dart' as _i12;
import '../../data/ParameterApi.dart' as _i13;
import '../../data/UserProgramApi.dart' as _i14;
import '../../data/TaskApi.dart' as _i15;
import '../../data/ProgramApi.dart' as _i16;
import '../../data/TaskAlarmApi.dart' as _i17;
import '../../data/TaskResultApi.dart' as _i18;
import '../../data/ProgramDialogApi.dart' as _i19;
import '../../data/ProfileApi.dart' as _i20;
import '../../data/AchievementApi.dart' as _i21;
import '../../data/NotificationUserApi.dart' as _i22;
import '../../data/ParameterValueApi.dart' as _i23;
import '../../data/UserFileApi.dart' as _i24;
import '../../data/MessageContainerApi.dart' as _i25;
import '../../data/MessageApi.dart' as _i26;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._(
      this._networkModule, this._appModule, this._mobxModule);

  final _i2.NetworkModule _networkModule;

  final _i3.AppModule _appModule;

  _i4.SharedPreferenceHelper _singletonSharedPreferenceHelper;

  final _i5.MobxModule _mobxModule;

  _i6.UserProfileStore _singletonUserProfileStore;

  _i7.UserProfileMessageStore _singletonUserProfileMessageStore;

  _i8.NotificationSenderStore _singletonNotificationSenderStore;

  _i9.ScreenUtils _singletonScreenUtils;

  static _i10.Future<_i1.AppComponent> create(_i3.AppModule appModule,
      _i2.NetworkModule networkModule, _i5.MobxModule mobxModule) async {
    final injector =
        AppComponent$Injector._(networkModule, appModule, mobxModule);

    return injector;
  }

  _i11.MyApp _createMyApp() => _i11.MyApp();
  _i12.UserApi _createUserApi() => _networkModule.provideUserApi();
  _i13.ParameterApi _createParameterApi() =>
      _networkModule.provideParameterApi();
  _i14.UserProgramApi _createUserProgramApi() =>
      _networkModule.provideUserProgramApi();
  _i15.TaskApi _createTaskApi() => _networkModule.provideTaskApi();
  _i16.ProgramApi _createProgramApi() => _networkModule.provideProgramApi();
  _i17.TaskAlarmApi _createTaskAlarmApi() =>
      _networkModule.provideTaskAlarmApi();
  _i18.TaskResultApi _createTaskResultApi() =>
      _networkModule.provideTaskResultApi();
  _i19.ProgramDialogApi _createProgramDialogApi() =>
      _networkModule.provideProgramDialogApi();
  _i20.ProfileApi _createProfileApi() => _networkModule.provideProfileApi();
  _i21.AchievementApi _createAchievementApi() =>
      _networkModule.provideAchievementApi();
  _i22.NotificationUserApi _createNotificationUserApi() =>
      _networkModule.provideNotificationUserApi();
  _i23.ParameterValueApi _createParameterValueApi() =>
      _networkModule.provideParameterValueApi();
  _i24.UserFileApi _createUserFileApi() => _networkModule.provideUserFileApi();
  _i25.MessageContainerApi _createMessageContainerApi() =>
      _networkModule.provideMessageContainerApi();
  _i26.MessageApi _createMessageApi() => _networkModule.provideMessageApi();
  _i4.SharedPreferenceHelper _createSharedPreferenceHelper() =>
      _singletonSharedPreferenceHelper ??=
          _appModule.provideSharedPreferenceHelper();
  _i6.UserProfileStore _createUserProfileStore() =>
      _singletonUserProfileStore ??= _mobxModule.provideUserProfileStore();
  _i7.UserProfileMessageStore _createUserProfileMessageStore() =>
      _singletonUserProfileMessageStore ??=
          _mobxModule.provideUserProfileMessageStore();
  _i8.NotificationSenderStore _createNotificationSenderStore() =>
      _singletonNotificationSenderStore ??=
          _mobxModule.provideNotificationSenderStore();
  _i9.ScreenUtils _createScreenUtils() =>
      _singletonScreenUtils ??= _appModule.provideScreenUtils();
  @override
  _i11.MyApp get app => _createMyApp();
  @override
  _i12.UserApi getUserApi() => _createUserApi();
  @override
  _i13.ParameterApi getParameterApi() => _createParameterApi();
  @override
  _i14.UserProgramApi getUserProgramApi() => _createUserProgramApi();
  @override
  _i15.TaskApi getTaskApi() => _createTaskApi();
  @override
  _i16.ProgramApi getProgramApi() => _createProgramApi();
  @override
  _i17.TaskAlarmApi getTaskAlarmApi() => _createTaskAlarmApi();
  @override
  _i18.TaskResultApi getTaskResultApi() => _createTaskResultApi();
  @override
  _i19.ProgramDialogApi getProgramDialogApi() => _createProgramDialogApi();
  @override
  _i20.ProfileApi getProfileApi() => _createProfileApi();
  @override
  _i21.AchievementApi getAchievementApi() => _createAchievementApi();
  @override
  _i22.NotificationUserApi getNotificationUserApi() =>
      _createNotificationUserApi();
  @override
  _i23.ParameterValueApi getParameterValueApi() => _createParameterValueApi();
  @override
  _i24.UserFileApi getUserFileApi() => _createUserFileApi();
  @override
  _i25.MessageContainerApi getMessageContainerApi() =>
      _createMessageContainerApi();
  @override
  _i26.MessageApi getMessageApi() => _createMessageApi();
  @override
  _i4.SharedPreferenceHelper getSharedPreferenceHelper() =>
      _createSharedPreferenceHelper();
  @override
  _i6.UserProfileStore getUserProfileStore() => _createUserProfileStore();
  @override
  _i7.UserProfileMessageStore getUserProfileMessageStore() =>
      _createUserProfileMessageStore();
  @override
  _i8.NotificationSenderStore getNotificationSenderStore() =>
      _createNotificationSenderStore();
  @override
  _i9.ScreenUtils getScreenUtils() => _createScreenUtils();
}
