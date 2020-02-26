import 'package:victume_mobile/data/network/constants/endpoints.dart';
import 'package:victume_mobile/data/network/dio_client.dart';
import 'package:victume_mobile/models/api/Program.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'BaseApi.dart';

class ProgramApi extends BaseApi {
  ProgramApi(DioClient dioClient) : super(dioClient);

  Future<Program> getBy(String programId) async {
    dynamic response = await dioClient.get("${Endpoints.program}/$programId");
    return MapConverter.toObject<Program>(
        response["result"]["data"], (program) => Program.fromMap(program));
  }
}
