import 'ApiModelBase.dart';

class Institution extends ApiModelBase {
  String id;
  String name;
  String address;
  String phoneNumber;
  String logo;

  Institution({this.id, this.name, this.address, this.phoneNumber, this.logo});

  @override
  factory Institution.fromMap(Map<String, dynamic> map) {
    return Institution(
        id: map["_id"],
        name: map["name"],
        address: map["address"],
        phoneNumber: map["phoneNumber"],
        logo: map["logo"]);
  }
}
