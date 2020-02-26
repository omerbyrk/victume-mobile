import 'package:victume_mobile/data/BaseApi.dart';
import 'package:victume_mobile/data/network/constants/endpoints.dart';
import 'package:victume_mobile/models/api/UserProgramView.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

class AuthUserProgramsResult {
  List<UserProgramView> userPrograms;
  int dataCount;
}

class UserProgramApi extends BaseApi {
  UserProgramApi(dioClient) : super(dioClient);

  Future<AuthUserProgramsResult> authUserProgramsLimit(int limit) async {
    dynamic response = await this.dioClient.get(
        Endpoints.authenticatedUserPrograms,
        queryParameters: {"limit": limit, "pageIndex": 0});

    AuthUserProgramsResult result = new AuthUserProgramsResult();

    result.userPrograms = MapConverter.toList<UserProgramView>(
        response["result"]["data"],
        (userProgram) => UserProgramView.fromMap(userProgram));
    result.dataCount = response["result"]["dataCount"];
    return result;
  }
}
