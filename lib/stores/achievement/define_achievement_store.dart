import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:victume_mobile/data/AchievementApi.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/stores/base_store.dart';
import 'package:victume_mobile/stores/notification/notification_sender.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';

part 'define_achievement_store.g.dart';

class DefineAchievementStore = _DefineAchievementStore
    with _$DefineAchievementStore;

abstract class _DefineAchievementStore extends BaseStore with Store {
  AchievementApi _achievementApi = appComponent.getAchievementApi();
  NotificationSenderStore _notificationSenderStore =
      appComponent.getNotificationSenderStore();
  UserProfileStore _userProfileStore = appComponent.getUserProfileStore();

  DefineAchievementFormStore formStore = DefineAchievementFormStore();

  @observable
  String achievementId;

  @action
  saveOrUpdateAchievement(AchievementDTO achievementDTO) async {
    try {
      this.loading = true;
      var result;
      if (achievementId != null) {
        result = await _achievementApi.update(achievementId, achievementDTO);
      } else {
        result = await _achievementApi.save(achievementDTO);
        achievementId = result.achievement.id;
        _notificationSenderStore.sendAchievementNewNotification(
            _userProfileStore
                .findFromAuthUserParamsBy(achievementDTO.parameterId)
                .name);
      }
      uiMessageStore.setSuccess(result.message);
    } on DioError catch (err) {
      uiMessageStore.setError(err.response.data["message"]);
    } finally {
      this.closeLoading();
    }
  }

  @action
  closeLoading() async {
    this.loading = _achievementApi.onProcess;
  }
}

class DefineAchievementFormStore = _DefineAchievementFormStore
    with _$DefineAchievementFormStore;

abstract class _DefineAchievementFormStore with Store {
  @observable
  String parameterId;

  @observable
  String targetValue;

  @observable
  DateTime targetDate;

  @computed
  String get parameterIdValidateText =>
      parameterId == null || parameterId.isEmpty
          ? "Parametre alanı gereklidir"
          : null;

  @computed
  String get targetValueValidateText =>
      targetValue == null || targetValue.isEmpty
          ? "Hedef değer alanı gereklidir"
          : null;

  @computed
  String get targetDateValidateText =>
      targetDate == null || DateTime.now().isAfter(targetDate)
          ? "Hedef tarih bugünün tarihinden küçük olamaz"
          : null;

  @action
  void setParameterId(String newValue) {
    this.parameterId = newValue;
  }

  @action
  void setTargetValue(String newValue) {
    this.targetValue = newValue;
  }

  @action
  void setTargetDate(DateTime newValue) {
    this.targetDate = newValue;
  }
}
