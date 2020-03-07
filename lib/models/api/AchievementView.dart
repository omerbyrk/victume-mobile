import 'package:victume_mobile/models/api/ApiModelBase.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

class AchievementView extends ApiModelBase {
  String id;
  String parameterId;
  String currentValue;
  String targetValue;
  DateTime createdDate;
  DateTime targetDate;
  String userId;
  String parameterValueId;
  String parameterName;
  String resultParameterValueId;
  bool result;
  bool active;

  AchievementView(
      {this.id,
      this.parameterId,
      this.currentValue,
      this.targetValue,
      this.createdDate,
      this.parameterName,
      this.resultParameterValueId,
      this.parameterValueId,
      this.targetDate,
      this.userId,
      this.active,
      this.result});

  factory AchievementView.fromMap(Map<String, dynamic> map) {
    return AchievementView(
        id: map["_id"],
        parameterId: map["parameterId"],
        currentValue: map["currentValue"],
        targetValue: map["targetValue"],
        createdDate: MapConverter.toDateTime(map["createdDate"]),
        targetDate: MapConverter.toDateTime(map["targetDate"]),
        userId: map["userId"],
        parameterValueId: map["parameterValueId"],
        resultParameterValueId: map["resultParameterValueId"],
        result: map["result"],
        active: map["active"],
        parameterName: map["parameterName"]);
  }
}
