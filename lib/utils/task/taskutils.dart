import 'package:victume_mobile/models/api/UserProgramView.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TaskUtils {
  TaskUtils() {
    initializeDateFormatting();
  }

  DateFormat _formatter;
  String getTaskDateAsString(UserProgramView userProgram) {
    if (isTaskFinished(userProgram)) return "Program sonlanmış";
    if (userProgram.startDate == null) return "Başlangıç tarihi belirtilmemiş";
    // 19 Aralık, Bugün
    // 20 Aralık, Çarşamba
    DateTime startDate = userProgram.startDate;
    String result = "";

    _formatter = new DateFormat.MMMMd('tr');

    if ((isTaskStarted(userProgram) && userProgram.isContinious)) {
      result = _formatter.format(DateTime.now()) + ", ";
      result += "Bugün";
    } else {
      result = _formatter.format(startDate) + ", ";
      _formatter = new DateFormat.EEEE('tr');
      result += _formatter.format(startDate);
    }
    return result;
  }

  static bool isTaskFinished(UserProgramView userProgramView) {
    if (userProgramView.isContinious) {
      return userProgramView.finishDate != null &&
          DateTime.now().compareTo(userProgramView.finishDate) > 0;
    } else {
      return isTaskStarted(userProgramView);
    }
  }

  static bool isTaskStarted(UserProgramView userProgramView) =>
      userProgramView.startDate != null &&
      DateTime.now().compareTo(userProgramView.startDate) > 0;
}
