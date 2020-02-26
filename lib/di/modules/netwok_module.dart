import 'package:dio/dio.dart';
import 'package:victume_mobile/data/AchievementApi.dart';
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
import 'package:victume_mobile/data/network/constants/endpoints.dart';
import 'package:victume_mobile/data/network/dio_client.dart';
import 'package:victume_mobile/data/sharedpref/constants/preferences.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  Dio provideDio() {
    Dio _dio = Dio()
      ..options.baseUrl = Endpoints.apiUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'};

    _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      // getting shared pref instance
      var prefs = await SharedPreferences.getInstance();

      // getting token
      var token = prefs.getString(Preferences.auth_token);

      if (token != null) options.headers["Authorization"] = "Bearer $token";
    }, onError: (DioError error) async {
      if (error.response?.statusCode == 401) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String token = preferences.getString(Preferences.auth_token);
        if (token != null) {
          Response response = await Dio().get(
              "${Endpoints.apiUrl}${Endpoints.refreshToken}",
              options:
                  new Options(headers: {"Authorization": "Bearer $token"}));
          print("Token is finished");
          print(response);
          String newToken = response.data["result"]["token"];
          bool tokenResult =
              await preferences.setString(Preferences.auth_token, newToken);
          if (tokenResult) {
            return _dio.request(error.response.request.path,
                options: error.response.request);
          }
        }
      }

      return error;
    }));

    return _dio;
  }

  @provide
  DioClient provideDioClient() => DioClient(provideDio());

  @provide
  UserApi provideUserApi() => UserApi(provideDioClient());

  @provide
  ParameterApi provideParameterApi() => ParameterApi(provideDioClient());

  @provide
  UserProgramApi provideUserProgramApi() => UserProgramApi(provideDioClient());

  @provide
  TaskApi provideTaskApi() => TaskApi(provideDioClient());

  @provide
  ProgramApi provideProgramApi() => ProgramApi(provideDioClient());

  @provide
  TaskAlarmApi provideTaskAlarmApi() => TaskAlarmApi(provideDioClient());

  @provide
  TaskResultApi provideTaskResultApi() => TaskResultApi(provideDioClient());

  @provide
  ProgramDialogApi provideProgramDialogApi() =>
      ProgramDialogApi(provideDioClient());

  @provide
  ProfileApi provideProfileApi() => ProfileApi(provideDioClient());

  @provide
  AchievementApi provideAchievementApi() => AchievementApi(provideDioClient());

  @provide
  NotificationUserApi provideNotificationUserApi() =>
      NotificationUserApi(provideDioClient());

  @provide
  ParameterValueApi provideParameterValueApi() =>
      ParameterValueApi(provideDioClient());

  @provide
  UserFileApi provideUserFileApi() => UserFileApi(provideDioClient());
}
