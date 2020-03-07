// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserProfileMessageStore on _UserProfileMessageStore, Store {
  Computed<int> _$authUserUnreaddedMessageCountComputed;

  @override
  int get authUserUnreaddedMessageCount =>
      (_$authUserUnreaddedMessageCountComputed ??=
              Computed<int>(() => super.authUserUnreaddedMessageCount))
          .value;

  final _$mentorMessageContainerAtom =
      Atom(name: '_UserProfileMessageStore.mentorMessageContainer');

  @override
  MessageContainer get mentorMessageContainer {
    _$mentorMessageContainerAtom.context
        .enforceReadPolicy(_$mentorMessageContainerAtom);
    _$mentorMessageContainerAtom.reportObserved();
    return super.mentorMessageContainer;
  }

  @override
  set mentorMessageContainer(MessageContainer value) {
    _$mentorMessageContainerAtom.context.conditionallyRunInAction(() {
      super.mentorMessageContainer = value;
      _$mentorMessageContainerAtom.reportChanged();
    }, _$mentorMessageContainerAtom,
        name: '${_$mentorMessageContainerAtom.name}_set');
  }

  final _$setUserAuthMentorMessageContainerAsyncAction =
      AsyncAction('setUserAuthMentorMessageContainer');

  @override
  Future<void> setUserAuthMentorMessageContainer() {
    return _$setUserAuthMentorMessageContainerAsyncAction
        .run(() => super.setUserAuthMentorMessageContainer());
  }

  final _$loadMoreMessageAsyncAction = AsyncAction('loadMoreMessage');

  @override
  Future<void> loadMoreMessage() {
    return _$loadMoreMessageAsyncAction.run(() => super.loadMoreMessage());
  }

  final _$pushMessageToMentorContainerByAsyncAction =
      AsyncAction('pushMessageToMentorContainerBy');

  @override
  Future<void> pushMessageToMentorContainerBy(String messageId) {
    return _$pushMessageToMentorContainerByAsyncAction
        .run(() => super.pushMessageToMentorContainerBy(messageId));
  }

  final _$sendMessageToMentorAsyncAction = AsyncAction('sendMessageToMentor');

  @override
  Future<void> sendMessageToMentor(String messageText) {
    return _$sendMessageToMentorAsyncAction
        .run(() => super.sendMessageToMentor(messageText));
  }

  final _$setMessageAsReaddedAsyncAction = AsyncAction('setMessageAsReadded');

  @override
  Future<void> setMessageAsReadded() {
    return _$setMessageAsReaddedAsyncAction
        .run(() => super.setMessageAsReadded());
  }

  final _$pushMessageToMentorContainerAsyncAction =
      AsyncAction('pushMessageToMentorContainer');

  @override
  Future<void> pushMessageToMentorContainer(Message message) {
    return _$pushMessageToMentorContainerAsyncAction
        .run(() => super.pushMessageToMentorContainer(message));
  }

  final _$initStoreAsyncAction = AsyncAction('initStore');

  @override
  Future<void> initStore() {
    return _$initStoreAsyncAction.run(() => super.initStore());
  }

  final _$closeLoadingAsyncAction = AsyncAction('closeLoading');

  @override
  Future closeLoading() {
    return _$closeLoadingAsyncAction.run(() => super.closeLoading());
  }
}
