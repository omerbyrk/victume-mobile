import 'package:victume_mobile/data/BaseApi.dart';
import 'package:victume_mobile/models/api/MessageContainer.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'network/constants/endpoints.dart';

class AuthUserMentorResultDTO {
  MessageContainer messageContainer;
  int unreaddedMessageCount;

  AuthUserMentorResultDTO({this.messageContainer, this.unreaddedMessageCount});
}

class MessageContainerApi extends BaseApi {
  MessageContainerApi(dioClient) : super(dioClient);

  Future<MessageContainer> authUserAndMentorMessageContainer() async {
    dynamic response = await this.dioClient.get(
        "${Endpoints.message_container_get_auth_user_and_mentor_container}");
    return MapConverter.toObject<MessageContainer>(response["result"]["data"],
        (container) => MessageContainer.fromMap(container));
  }

  Future<MessageContainer> insert(Map<String, dynamic> data) async {
    dynamic response = await this
        .dioClient
        .post("${Endpoints.message_container_insert}", data: {"insert": data});
    return MapConverter.toObject<MessageContainer>(response["result"]["data"],
        (container) => MessageContainer.fromMap(container));
  }
}
