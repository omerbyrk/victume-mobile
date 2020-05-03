class Endpoints {
  Endpoints._();


  //static const String baseUrl = "http://192.168.2.220:5000"; // nenemler

  static const String baseUrl = "http://192.168.1.33:5000"; // ev

 //static const String baseUrl = "http://victumedb.fastsoft.com.tr"; // heroku
  // base url
  static const String apiUrl = "$baseUrl/api/v1";
  // receiveTimeout
  static const int receiveTimeout = 200000;
  // connectTimeout
  static const int connectionTimeout = 100000;

  //user
  static const String singin = "/user/signin";
  static const String authenticatedUser = "/views/user/authenticated_user";
  static const String refreshToken = "/user/refresh_token";
  static const String set_auth_user_fcm_token = "/user/set_auth_user_fcm_token";

  //parameters
  static const String authenticatedUserDefaultParameters =
      "/views/parameter-and-default-value/authenticated_user";
  static const String updateParameterValue = "/parameter-value";
  static const String set_new_parameter_value_as_default =
      "/parameter-value/set_new_parameter_value_as_default";
  static const String set_parent_parameter_value_as_default =
      "/parameter-value/set_parent_parameter_value_as_default";

  // user-program
  static const String authenticatedUserPrograms =
      "/views/user-program/get_by_authenticated_user";

  // program
  static const String program = "/program";
  static const String get_dialog_by_program_id = "/program-dialog/program";

  //task
  static const String get_task_view_by_program_id = "/views/task/program_id";
  static const String find_task_alarm = "/task-alarm/find";
  static const String task_alarm = "/task-alarm";
  static const String get_today_task_result = "/task-result/get_for_today";
  static const String task_result = "/task-result";

  // profile
  static const String profile_upload_photo = "/profile/photo";

  // achievement
  static const String achievement_view = "/views/achievement";
  static const String achievement = "/achievement";

  // notification
  static const String get_auth_user_notifications =
      "/notification-user/auth_notification_limit";
  static const String send_notification_mentor =
      "/notification-user/send_notification_mentor";
  static const String set_readed_all_auth_user_notifications =
      "/notification-user/set_readed_all_auth_user_notifications";

  static const String get_notification_image =
      "/notification-user/get_notification_image";

  // user file
  static const String user_file_insert = "/user-file/";
  static const String user_file_delete = "/user-file/";
  static const String user_file_get_all = "/user-file/get_all";

  // message
  static const String message_container_get_auth_user_and_mentor_container =
      "/message-container/get_auth_user_and_mentor_container";
  static const String message_container_insert = "/message-container/";
  static const String message_send = "/message/send";
  static const String message_base = "/message";
  static const String message_get_all =
      "/message/get_all_by_message_container_id";
  static const String message_set_readded =
      "/message/set_readded_by_message_container_id_and_user_id";
}
