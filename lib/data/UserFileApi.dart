import 'dart:io';

import 'package:dio/dio.dart';
import 'package:victume_mobile/data/BaseApi.dart';
import 'package:victume_mobile/data/network/constants/endpoints.dart';
import 'package:victume_mobile/models/api/UserFile.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

class UserFileProcessResult {
  String message;
  bool success;

  UserFileProcessResult({this.message, this.success});
}

class UserFileApi extends BaseApi {
  UserFileApi(dioClient) : super(dioClient);

  Future<List<UserFile>> getListBy(Map<String, String> queryParameters) async {
    dynamic response = await this.dioClient.get(
        "${Endpoints.user_file_get_all}",
        queryParameters: queryParameters);
    return MapConverter.toList<UserFile>(
        response["result"]["data"], (userFile) => UserFile.fromMap(userFile));
  }

  Future<UserFileProcessResult> delete(String userFileId) async {
    dynamic response = await this
        .dioClient
        .delete("${Endpoints.user_file_delete}/$userFileId");

    return UserFileProcessResult(
        success: response["success"], message: response["message"]);
  }

  Future<UserFileProcessResult> insertBy(
      File file, String fileType, String userId) async {
    String fileName = file.path.split('/').last;
    FormData data = FormData.from({
      "file": UploadFileInfo(file, fileName,
          contentType: ContentType.parse("image/jpeg")),
      "fileType": fileType,
      "userId": userId
    });
    dynamic response = await this.dioClient.patch(
        "/${Endpoints.user_file_insert}/",
        data: data,
        options: RequestOptions(
            contentType: ContentType.parse("multipart/form-data"),
            headers: {'Content-Type': 'multipart/form-data'}));
    return UserFileProcessResult(
        success: response["success"], message: response["message"]);
  }

}
