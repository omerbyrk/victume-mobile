import 'package:victume_mobile/data/BaseApi.dart';
import 'package:victume_mobile/data/network/constants/endpoints.dart';
import 'package:victume_mobile/models/api/UserView.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

class AuthenticationResultDTO {
  String message;
  String token;
  bool success;
  AuthenticationResultDTO({this.message, this.token, this.success});
}

class UserApi extends BaseApi {
  UserApi(_dioClient) : super(_dioClient);

  Future<AuthenticationResultDTO> authenticate(
      [String email, String password]) async {
    dynamic response = await super.dioClient.post(Endpoints.singin,
        data: {"email": email, "password": password, "envoriment": "mobile"});
    return AuthenticationResultDTO(
        token: MapConverter.toObject<String>(
            response["result"]["token"], (token) => token.toString()),
        message: response["message"],
        success: response["success"]);
  }

  Future<UserView> authenticatedUser() async {
    dynamic response = await this.dioClient.get(Endpoints.authenticatedUser);
    return MapConverter.toObject<UserView>(
        response["result"]["data"], (user) => UserView.fromMap(user));
  }

  Future<bool> setAuthUserFcmToken(String fcmToken) async {
    dynamic response = await this.dioClient.patch(
        Endpoints.set_auth_user_fcm_token,
        data: {"fcmUserToken": fcmToken});
    return response["success"];
  }
}
