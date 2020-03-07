import 'package:victume_mobile/data/BaseApi.dart';
import 'package:victume_mobile/models/api/ParameterValue.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'network/constants/endpoints.dart';

class NewParameterValueAsDefaultDTO {
  String parameterId;
  String userId;
  String value;

  NewParameterValueAsDefaultDTO({this.parameterId, this.userId, this.value});

  Map<String, dynamic> toMap() =>
      {"parameterId": parameterId, "userId": userId, "value": value};
}

class ParameterValueApi extends BaseApi {
  ParameterValueApi(dioClient) : super(dioClient);

  Future<bool> update(
      String parameterValueId, Map<String, dynamic> body) async {
    dynamic response = await this.dioClient.patch(
        "${Endpoints.updateParameterValue}/$parameterValueId",
        data: {"update": body});

    return response["success"];
  }

  Future<ParameterValue> setNewParameterValueAsDefault(
      NewParameterValueAsDefaultDTO setNewParameterAsDefaultDTO) async {
    dynamic response = await this.dioClient.patch(
        "${Endpoints.set_new_parameter_value_as_default}",
        data: setNewParameterAsDefaultDTO.toMap());

    return MapConverter.toObject(response["result"]["data"],
        (parameterValue) => ParameterValue.fromMap(parameterValue));
  }

  Future<ParameterValue> setParentParameterValueAsDefault(
      String userId, String parameterId) async {
    dynamic response = await this.dioClient.patch(
        "${Endpoints.set_parent_parameter_value_as_default}",
        data: {"userId": userId, "parameterId": parameterId});

    return MapConverter.toObject(response["result"]["data"],
        (parameterValue) => ParameterValue.fromMap(parameterValue));
  }
}
