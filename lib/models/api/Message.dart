import 'package:victume_mobile/utils/MapConverter.dart';

import 'ApiModelBase.dart';

class To {
  String to;
  bool isRead;

  To({this.to, this.isRead});

  @override
  factory To.fromMap(Map<String, dynamic> map) {
    return To(to: map["to"], isRead: map["isRead"]);
  }
}

class Message extends ApiModelBase {
  String id;
  String messageContainerId;
  String message;
  String from;
  List<To> toList;
  DateTime createdDate;

  Message(
      {this.id,
      this.messageContainerId,
      this.message,
      this.from,
      this.toList,
      this.createdDate});

  @override
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map["_id"],
      messageContainerId: map["messageContainerId"],
      message: map["message"],
      from: map["from"],
      toList: MapConverter.toList(map["toList"], (to) => To.fromMap(to)),
      createdDate: MapConverter.toDateTime(map["createdDate"]),
    );
  }
}
