import 'package:victume_mobile/data/BaseApi.dart';

import 'network/constants/endpoints.dart';

class ParameterValueApi extends BaseApi {
  ParameterValueApi(dioClient) : super(dioClient);

  Future<bool> update(
      String parameterValueId, Map<String, dynamic> body) async {
    dynamic response = await this.dioClient.patch(
        "${Endpoints.updateParameterValue}/$parameterValueId",
        data: {"update": body});

    print(response);
    return response["success"];
  }
}
