import 'package:victume_mobile/models/api/ApiModelBase.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

class Achievement extends ApiModelBase {
  String id;
  String parameterId;
  String targetValue;
  DateTime createdDate;
  DateTime targetDate;
  String userId;
  bool result;
  bool active;
  String resultParameterValueId;

  Achievement(
      {this.id,
      this.parameterId,
      this.targetValue,
      this.createdDate,
      this.targetDate,
      this.userId,
      this.active,
      this.resultParameterValueId,
      this.result});

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
        id: map["_id"],
        parameterId: map["parameterId"],
        targetValue: map["targetValue"],
        createdDate: MapConverter.toDateTime(map["createdDate"]),
        targetDate: MapConverter.toDateTime(map["targetDate"]),
        userId: map["userId"],
        result: map["result"],
        resultParameterValueId: map["resultParameterValueId"],
        active: map["active"]);
  }
}
