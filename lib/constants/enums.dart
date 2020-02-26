enum CustomMenuItemValue { AchievementList, MeasurementList, Logout }

enum MessageCardType { RECEIVER, SENDER }

enum DeviceSizeType {
  xSmall,
  Small,
  xMiddle,
  Middle,
  Normal,
  Large,
  xLarge,
  Ultra,
  Mega
}

enum IconSizeType {
  xSmall,
  Small,
  Normal,
  Large,
  xLarge,
  xxLarge,
  Mega,
  xMega,
  xxMega
}

class NotificationTypes {
  static const String ACHIEVEMENT_DONE = "ACHIEVEMENT_DONE";
  static const String ACHIEVEMENT_NEW = "ACHIEVEMENT_NEW";
  static const String ACHIEVEMENT_BACK = "ACHIEVEMENT_BACK";
  static const String TASK_DONE = "TASK_DONE";
  static const String PARAMETER_NOT_FOUND = "PARAMETER_NOT_FOUND";
}

class UserFileTypes {
  static const String MEASUREMENT = "MEASUREMENT";
}