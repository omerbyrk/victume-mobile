import 'package:victume_mobile/utils/MapConverter.dart';

import 'ApiModelBase.dart';

class ParameterValue extends ApiModelBase{
  String id;
  String parameterId;
  String groupId;
  String value;
  String userId;
  DateTime createdDate;
  bool isDefault;

  ParameterValue(
      {this.id,
      this.parameterId,
      this.groupId,
      this.value,
      this.userId,
      this.createdDate,
      this.isDefault});

  factory ParameterValue.fromMap(Map<String, dynamic> map) {
    return ParameterValue(
        id: map["_id"],
        parameterId: map["parameterId"],
        groupId: map["groupId"],
        value: map["value"],
        userId: map["userId"],
        createdDate: MapConverter.toDateTime(map["createdDate"]),
        isDefault: map["isDefault"]);
  }
}
