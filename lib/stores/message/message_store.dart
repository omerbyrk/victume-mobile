import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/models/widget/Message.dart';
import 'package:mobx/mobx.dart';

part 'message_store.g.dart';

class MessageStore = _MessageStore with _$MessageStore;

abstract class _MessageStore with Store {
  @observable
  ObservableList<Message> messageList = new ObservableList.of([
    Message(message: "Merhabalar hocam", type: MessageCardType.SENDER),
    Message(
        message: "Bir şey sorabilir miyim... müsait misiniz?",
        type: MessageCardType.SENDER),
    Message(message: "Tabii ki", type: MessageCardType.RECEIVER),
    Message(message: "Buyrun", type: MessageCardType.RECEIVER),
  ]);

  @action
  send(Message message) {
    this.messageList.add(message);
  }
}
