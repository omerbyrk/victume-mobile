import 'dart:io';

import 'package:dio/dio.dart';
import 'package:victume_mobile/data/BaseApi.dart';

import 'network/constants/endpoints.dart';

class ProfileApi extends BaseApi {
  ProfileApi(dioClient) : super(dioClient);

  Future<String> uploadPhoto(String profileId, File photo) async {
    String fileName = photo.path.split('/').last;
    FormData data = FormData.from({
      "photo": UploadFileInfo(photo, fileName,
          contentType: ContentType.parse("image/jpeg"))
    });

    dynamic response = await this.dioClient.patch(
        "${Endpoints.profile_upload_photo}/$profileId",
        data: data,
        options: RequestOptions(
            contentType: ContentType.parse("multipart/form-data"),
            headers: {'Content-Type': 'multipart/form-data'}));

    return response["message"];
  }
}
