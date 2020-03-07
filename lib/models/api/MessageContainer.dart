import 'package:victume_mobile/models/api/ProfileView.dart';
import 'package:victume_mobile/utils/MapConverter.dart';

import 'ApiModelBase.dart';
import 'Message.dart';

class MessageContainer extends ApiModelBase {
  String id;
  List<ProfileView> profiles;
  List<Message> messages;

  MessageContainer({this.id, this.profiles, this.messages});

  @override
  factory MessageContainer.fromMap(Map<String, dynamic> map) {
    return MessageContainer(
        id: map["_id"],
        messages: MapConverter.toList(
            map["messages"], (message) => Message.fromMap(message)),
        profiles: MapConverter.toList(
            map["profiles"], (profile) => ProfileView.fromMap(profile)));
  }

  @override
  factory MessageContainer.clone(MessageContainer container) {
    return MessageContainer(
        id: container.id,
        profiles: container.profiles,
        messages: container.messages);
  }
}
