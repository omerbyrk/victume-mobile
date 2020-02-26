import 'package:victume_mobile/data/network/constants/endpoints.dart';
import 'package:victume_mobile/data/network/dio_client.dart';
import 'package:victume_mobile/models/api/ProgramDialog.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'BaseApi.dart';

class ProgramDialogApi extends BaseApi {
  ProgramDialogApi(DioClient dioClient) : super(dioClient);

  Future<ProgramDialog> getBy(String programId) async {
    dynamic response =
        await dioClient.get("${Endpoints.get_dialog_by_program_id}/$programId");
    return MapConverter.toObject<ProgramDialog>(
        response["result"]["data"], (dialog) => ProgramDialog.fromMap(dialog));
  }
}
