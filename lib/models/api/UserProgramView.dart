import 'package:victume_mobile/models/api/Program.dart';
import 'package:victume_mobile/models/api/User.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'ApiModelBase.dart';

class UserProgramView extends ApiModelBase {
  String id;
  User user;
  Program program;
  DateTime startDate;
  DateTime finishDate;
  bool isContinious;
  bool active;

  UserProgramView(
      {this.id,
      this.user,
      this.program,
      this.startDate,
      this.finishDate,
      this.isContinious,
      this.active});

  factory UserProgramView.fromMap(Map<String, dynamic> map) {
    print(map["finishDate"]);
    return UserProgramView(
        id: map["_id"],
        user: MapConverter.toObject<User>(
            map["user"], (user) => User.fromMap(user)),
        program: MapConverter.toObject<Program>(
            map["program"], (program) => Program.fromMap(program)),
        startDate: MapConverter.toDateTime(map["startDate"]),
        finishDate: MapConverter.toDateTime(map["finishDate"]),
        isContinious: map["isContinious"],
        active: map["active"]);
  }
}
