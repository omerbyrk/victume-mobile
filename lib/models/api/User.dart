import 'ApiModelBase.dart';

class User extends ApiModelBase{
  String id;
  String email;
  String fcmUserToken;
  bool active;
  String institutionId;
  String roleId;

  User(
      {this.id,
      this.email,
      this.fcmUserToken,
      this.active,
      this.institutionId,
      this.roleId});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map["_id"],
        email: map["email"],
        fcmUserToken: map["fcmUserToken"],
        active: map["active"],
        institutionId: map["institutionId"],
        roleId: map["roleId"]);
  }
}
