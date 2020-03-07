import 'package:victume_mobile/models/api/Institution.dart';
import 'package:victume_mobile/models/api/ProfileView.dart';
import 'package:victume_mobile/models/api/Role.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'ApiModelBase.dart';

class UserView extends ApiModelBase {
  String id;
  String email;
  String fcmUserToken;
  String mentorId;
  ProfileView profile;
  Role role;
  Institution institution;

  UserView(
      {this.id,
      this.email,
      this.fcmUserToken,
      this.mentorId,
      this.profile,
      this.role,
      this.institution});

  factory UserView.fromMap(Map<String, dynamic> map) {
    return UserView(
        id: map["_id"],
        email: map["email"],
        fcmUserToken: map["fcmUserToken"],
        mentorId: map["mentorId"],
        profile: MapConverter.toObject<ProfileView>(
            map["profile"], (profile) => ProfileView.fromMap(profile)),
        role: MapConverter.toObject<Role>(
            map["role"], (role) => Role.fromMap(role)),
        institution: MapConverter.toObject<Institution>(
            map["institution"], (role) => Institution.fromMap(role)));
  }
}
