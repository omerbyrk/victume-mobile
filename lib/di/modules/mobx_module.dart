import 'package:inject/inject.dart';
import 'package:victume_mobile/stores/notification/notification_sender.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_message_store.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';

@module
class MobxModule {
  @provide
  @singleton
  UserProfileStore provideUserProfileStore() => UserProfileStore();

  @provide
  @singleton
  UserProfileMessageStore provideUserProfileMessageStore() =>
      UserProfileMessageStore();

  @provide
  @singleton
  NotificationSenderStore provideNotificationSenderStore() =>
      NotificationSenderStore();
}
