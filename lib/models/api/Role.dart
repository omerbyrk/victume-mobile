import 'ApiModelBase.dart';

class Role extends ApiModelBase {
  String id;
  String name;

  Role({this.id, this.name});

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(id: map["_id"], name: map["name"]);
  }
}
