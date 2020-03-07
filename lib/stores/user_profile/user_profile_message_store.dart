import 'package:dio/dio.dart';
import 'package:victume_mobile/data/MessageApi.dart';
import 'package:victume_mobile/data/MessageContainerApi.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/models/api/Message.dart';
import 'package:victume_mobile/models/api/MessageContainer.dart';
import 'package:mobx/mobx.dart';
import 'package:victume_mobile/models/api/ProfileView.dart';
import 'package:victume_mobile/stores/base_store.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';

part 'user_profile_message_store.g.dart';

class UserProfileMessageStore = _UserProfileMessageStore
    with _$UserProfileMessageStore;

abstract class _UserProfileMessageStore extends BaseStore with Store {
  MessageContainerApi _messageContainerApi =
      appComponent.getMessageContainerApi();
  MessageApi _messageApi = appComponent.getMessageApi();

  UserProfileStore _userProfileStore = appComponent.getUserProfileStore();

  Function onPushedMessage;

  @observable
  MessageContainer mentorMessageContainer;

  @computed
  int get authUserUnreaddedMessageCount {
    if (mentorMessageContainer != null &&
        mentorMessageContainer.messages.isNotEmpty) {
      return mentorMessageContainer.messages
          .where((message) => message.toList.any(
                (toObject) =>
                    toObject.to == _userProfileStore.authenticatedUser.id &&
                    toObject.isRead == false,
              ))
          .length;
    }
    return 0;
  }

  @action
  Future<void> setUserAuthMentorMessageContainer() async {
    try {
      this.loading = true;
      var result =
          (await _messageContainerApi.authUserAndMentorMessageContainer());
      this.mentorMessageContainer = result;
      if (this.mentorMessageContainer == null) {
        mentorMessageContainer = (await _messageContainerApi.insert({
          "users": [
            _userProfileStore.authenticatedUser.id,
            _userProfileStore.authenticatedUser.mentorId
          ]
        }));
      } else {}
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  Future<void> loadMoreMessage() async {
    try {
      mentorMessageContainer.messages = await _messageApi.getAllBy(
          mentorMessageContainer.id,
          mentorMessageContainer.messages.length + 10);
      mentorMessageContainer = MessageContainer.clone(mentorMessageContainer);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    }
  }

  @action
  Future<void> pushMessageToMentorContainerBy(String messageId) async {
    try {
      Message message = await _messageApi.get(messageId);
      this.pushMessageToMentorContainer(message);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    }
  }

  @action
  Future<void> sendMessageToMentor(String messageText) async {
    try {
      Message message = await _messageApi.send(SendMessageDTO(
        message: messageText,
        from: _userProfileStore.authenticatedUser.id,
        messageContainerId: mentorMessageContainer.id,
      ));
      this.pushMessageToMentorContainer(message);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    }
  }

  @action
  Future<void> setMessageAsReadded() async {
    try {
      if (authUserUnreaddedMessageCount > 0) {
        mentorMessageContainer = await _messageApi.setMessagesAsReaddedBy(
            mentorMessageContainer.id, _userProfileStore.authenticatedUser.id);
      }
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    }
  }

  @action
  Future<void> pushMessageToMentorContainer(Message message) async {
    mentorMessageContainer.messages.add(message);
    mentorMessageContainer = MessageContainer.clone(mentorMessageContainer);
    if (onPushedMessage != null) onPushedMessage();
  }

  ProfileView get mentorProfile {
    return this.mentorMessageContainer.profiles.firstWhere((profile) =>
        profile.userId == _userProfileStore.authenticatedUser.mentorId);
  }

  @action
  Future<void> initStore() async {
    this.setUserAuthMentorMessageContainer();
  }

  @action
  closeLoading() async {
    this.loading = _messageApi.onProcess || _messageContainerApi.onProcess;
  }
}
