import 'package:victume_mobile/utils/MapConverter.dart';

import 'ApiModelBase.dart';

class UserFile extends ApiModelBase {
  String id;
  String userId;
  String filePath;
  String fileType;
  String fileName;
  DateTime createdDate;

  UserFile(
      {this.id,
      this.userId,
      this.filePath,
      this.fileType,
      this.fileName,
      this.createdDate});

  factory UserFile.fromMap(Map<String, dynamic> map) {
    return UserFile(
        id: map["_id"],
        userId: map["userId"],
        filePath: map["filePath"],
        fileType: map["fileType"],
        fileName: map["fileName"],
        createdDate: MapConverter.toDateTime(map["createdDate"]));
  }
}
