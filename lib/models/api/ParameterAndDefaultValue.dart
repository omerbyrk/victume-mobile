import 'package:victume_mobile/models/api/ParameterValue.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'ApiModelBase.dart';

class ParameterAndDefaultValue extends ApiModelBase {
  String id;
  String name;
  bool onProfile;
  int order;
  bool active;
  String institutionId;
  ParameterValue parameterValue;

  ParameterAndDefaultValue(
      {this.id,
      this.name,
      this.onProfile,
      this.order,
      this.active,
      this.institutionId,
      this.parameterValue});

  factory ParameterAndDefaultValue.fromMap(Map<String, dynamic> map) {
    return ParameterAndDefaultValue(
        id: map["_id"],
        name: map["name"],
        onProfile: map["onProfile"],
        order: map["order"],
        active: map["active"],
        institutionId: map["institutionId"],
        parameterValue: MapConverter.toObject<ParameterValue>(map["value"],
            (parameterValue) => ParameterValue.fromMap(parameterValue)));
  }
}
