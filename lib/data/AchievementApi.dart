import 'package:victume_mobile/data/BaseApi.dart';
import 'package:victume_mobile/models/api/Achievement.dart';
import 'package:victume_mobile/models/api/AchievementView.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'network/constants/endpoints.dart';

class AchievementDTO {
  String targetValue;
  DateTime targetDate;
  String parameterId;
  String userId;
  String parameterValueId;
  String currentValue;

  AchievementDTO(
      {this.targetDate,
      this.parameterId,
      this.parameterValueId,
      this.currentValue,
      this.targetValue,
      this.userId});

  Map<String, dynamic> toMap() => {
        "targetValue": targetValue,
        "targetDate": targetDate.toString(),
        "parameterId": parameterId,
        "parameterValueId": parameterValueId,
        "currentValue": currentValue,
        "userId": userId
      };
}

class AchievementSaveResultDTO {
  String message;
  Achievement achievement;

  AchievementSaveResultDTO({this.message, this.achievement});
}

class AchievementUpdateResultDTO {
  String message;
  bool success;

  AchievementUpdateResultDTO({this.message, this.success});
}

class AchievementApi extends BaseApi {
  AchievementApi(dioClient) : super(dioClient);

  Future<List<AchievementView>> getListBy(
      Map<String, dynamic> queryParameters) async {
    dynamic response = await this
        .dioClient
        .get(Endpoints.achievement_view, queryParameters: queryParameters);
    return MapConverter.toList<AchievementView>(response["result"]["data"],
        (achievement) => AchievementView.fromMap(achievement));
  }

  Future<AchievementView> getBy(String achievementId) async {
    dynamic response = await this
        .dioClient
        .get("${Endpoints.achievement_view}/$achievementId");
    return MapConverter.toObject<AchievementView>(response["result"]["data"],
        (achievement) => AchievementView.fromMap(achievement));
  }

  Future<AchievementUpdateResultDTO> update(
      String achievementId, AchievementDTO achievementDTO) async {
    dynamic response = await this.dioClient.patch(
        "${Endpoints.achievement}/$achievementId",
        data: {"update": achievementDTO.toMap()});
    return AchievementUpdateResultDTO(
        success: response["success"], message: response["message"]);
  }

  Future<AchievementUpdateResultDTO> updateBy(
      String achievementId, Map<String, dynamic> map) async {
    dynamic response = await this.dioClient.patch(
        "${Endpoints.achievement}/$achievementId",
        data: {"update": map});
    return AchievementUpdateResultDTO(
        success: response["success"], message: response["message"]);
  }

  Future<AchievementSaveResultDTO> save(AchievementDTO achievementDTO) async {
    dynamic response = await this.dioClient.post("${Endpoints.achievement}",
        data: {"insert": achievementDTO.toMap()});
    return AchievementSaveResultDTO(
        achievement: MapConverter.toObject<Achievement>(
            response["result"]["data"],
            (achievement) => Achievement.fromMap(achievement)),
        message: response["message"]);
  }

  Future<String> delete(String achievementId) async {
    dynamic response =
        await this.dioClient.delete("${Endpoints.achievement}/$achievementId");
    return response["message"];
  }
}
