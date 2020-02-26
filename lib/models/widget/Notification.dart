import 'package:flutter/cupertino.dart';

class Notification {
  String title;
  Duration timestamp;
  IconData icon;
  bool isNew;

  Notification({this.title, this.timestamp, this.icon, this.isNew});
}
