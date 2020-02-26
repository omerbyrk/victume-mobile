import 'package:timeago/timeago.dart' as timeago;

class TimeAgoHelper {
  static String timeAgo(DateTime time) {
    String result = timeago.format(
        DateTime.now().subtract(DateTime.now().difference(time)),
        locale: 'tr',
        allowFromNow: true);

    return result.replaceAll("şimdi", "kaldı");
  }
}
