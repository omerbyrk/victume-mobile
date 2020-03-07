import 'package:victume_mobile/data/BaseApi.dart';
import 'package:victume_mobile/models/api/Message.dart';
import 'package:victume_mobile/models/api/MessageContainer.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'network/constants/endpoints.dart';

class SendMessageDTO {
  String messageContainerId;
  String message;
  String from;

  SendMessageDTO({this.message, this.from, this.messageContainerId});

  Map<String, dynamic> toMap() => {
        "messageContainerId": messageContainerId,
        "message": message,
        "from": from
      };
}

class MessageApi extends BaseApi {
  MessageApi(dioClient) : super(dioClient);

  Future<Message> send(SendMessageDTO sendMessageDTO) async {
    dynamic response = await this
        .dioClient
        .post("${Endpoints.message_send}", data: sendMessageDTO.toMap());
    return MapConverter.toObject<Message>(
        response["result"]["data"], (message) => Message.fromMap(message));
  }

  Future<List<Message>> getAllBy(String messageContainerId, int limit) async {
    dynamic response = await this.dioClient.get(
        "${Endpoints.message_get_all}/$messageContainerId",
        queryParameters: {"limit": limit, "pageIndex": 0});
    return MapConverter.toList<Message>(
        response["result"]["data"], (message) => Message.fromMap(message));
  }

  Future<MessageContainer> setMessagesAsReaddedBy(
      String messageContainerId, String userId) async {
    dynamic response = await this
        .dioClient
        .patch("${Endpoints.message_set_readded}/$messageContainerId/$userId");
    return MapConverter.toObject<MessageContainer>(response["result"]["data"],
        (messageContainer) => MessageContainer.fromMap(messageContainer));
  }

    Future<Message> get(
      String messageId) async {
    dynamic response = await this
        .dioClient
        .get("${Endpoints.message_base}/$messageId");
    return MapConverter.toObject<Message>(response["result"]["data"],
        (message) => Message.fromMap(message));
  }
}
