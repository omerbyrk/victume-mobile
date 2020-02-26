import 'package:victume_mobile/data/BaseApi.dart';
import 'package:victume_mobile/models/api/ParameterAndDefaultValue.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'network/constants/endpoints.dart';

class ParameterApi extends BaseApi {
  ParameterApi(dioClient) : super(dioClient);

  Future<List<ParameterAndDefaultValue>>
      authenticatedUserDefaultParameters() async {
    dynamic response =
        await this.dioClient.get(Endpoints.authenticatedUserDefaultParameters);
    return MapConverter.toList<ParameterAndDefaultValue>(
        response["result"]["data"],
        (parameter) => ParameterAndDefaultValue.fromMap(parameter));
  }
}
