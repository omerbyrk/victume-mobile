import 'package:victume_mobile/utils/MapConverter.dart';

import 'ApiModelBase.dart';

class ProfileView extends ApiModelBase{
  String id;
  String name;
  String surname;
  String phoneNumber;
  String address;
  String photo;
  String fullname;
  int age;
  DateTime birthDate;
  String userId;

  ProfileView(
      {this.id,
      this.name,
      this.surname,
      this.phoneNumber,
      this.address,
      this.fullname,
      this.age,
      this.photo,
      this.birthDate,
      this.userId});

  factory ProfileView.fromMap(Map<String, dynamic> map) {
    return ProfileView(
        id: map["_id"],
        name: map["name"],
        surname: map["surname"],
        address: map["address"],
        fullname: map["fullname"],
        age: (map["age"] as double).toInt(),
        phoneNumber: map["phoneNumber"],
        photo: map["photo"],
        birthDate: MapConverter.toDateTime(map["birthDate"]),
        userId: map["userId"]);
  }
}
