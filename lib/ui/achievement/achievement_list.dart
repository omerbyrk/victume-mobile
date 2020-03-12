import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/data/ParameterValueApi.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/models/api/AchievementView.dart';
import 'package:victume_mobile/models/api/ParameterValue.dart';
import 'package:victume_mobile/stores/achievement/achievement_list_store.dart';
import 'package:victume_mobile/stores/notification/notification_sender.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';
import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:victume_mobile/ui/achievement/achievement_card.dart';
import 'package:victume_mobile/ui/achievement/define_achievement.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:animated_background/animated_background.dart';

class AchievementListScreen extends StatefulWidget {
  @override
  _AchievementListScreenState createState() => _AchievementListScreenState();
}

class _AchievementListScreenState
    extends ScreenStatefulBase<AchievementListScreen>
    with TickerProviderStateMixin {
  AchievementListStore _achievementListStore = new AchievementListStore();
  UserProfileStore _userProfileStore = appComponent.getUserProfileStore();
  NotificationSenderStore _notificationSenderStore =
      appComponent.getNotificationSenderStore();

  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    _achievementListStore
        .setAchievementList(_userProfileStore.authenticatedUser.id);

    animationController = new AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1,
      value: 0,
      duration: new Duration(milliseconds: 1000),
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceInOut);
    animation.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._buildAppBar(),
      body: this._buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this.navigatePush((_) => DefineAchievementScreen(
                onDispose: () => this.doDelayedTask(() =>
                    _achievementListStore.setAchievementList(
                        _userProfileStore.authenticatedUser.id)),
              ));
        },
        child: Icon(
          Icons.add,
          size: this.calIconSize(IconSizeType.Large),
          color: Colors.white,
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
        elevation: 5.0,
        actions: <Widget>[
          InkWell(
            onTap: () => super.navigatePop(),
            child: Icon(Icons.close,
                color: Colors.white,
                size: this.calIconSize(IconSizeType.Large)),
          ),
          SizedBox(
            width: this.calSizeForDevice(10),
          )
        ],
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Icon(
              Icons.stars,
              size: this.calIconSize(IconSizeType.Large),
              color: Colors.white,
            ),
            SizedBox(
              width: this.calSizeForDevice(10.0),
            ),
            Expanded(
              child: Text(
                "Hedeflerim",
                overflow: TextOverflow.ellipsis,
                style: TextStyles.xLargeText.whiteColor().isBolder().ok(),
              ),
            )
          ],
        ));
  }

  _buildBody() {
    return Provider(
        create: (_) => _achievementListStore,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: this.calSizeForDevice(15),),
                Observer(
                  builder: (_) {
                    return Expanded(
                      child: this._achievementListStore.isReadyAchievementList
                          ? ListView.builder(
                              itemBuilder: (_, index) {
                                AchievementView achievementView =
                                    _achievementListStore
                                        .achievementList[index];
                                return AchievementCard(
                                    achievementView: achievementView,
                                    onDeleteButtonAction:
                                        this._onDeleteButtonAction,
                                    onResultToggleButtonAction:
                                        _onResultToggleButtonAction);
                              },
                              itemCount:
                                  _achievementListStore.achievementList.length)
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    "Henüz hiç hedef belirlenmemiş",
                                    style: TextStyles.largeText.isBolder().ok(),
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                )
              ],
            ),
            this.buildIndicator(_achievementListStore),
            this.buildUIMessageHandler(_achievementListStore),
            this._buildCongratulationsLayer(),
            this._buildCongratulationsLayerItem()
          ],
        ));
  }

  _onResultToggleButtonAction(AchievementView achievementView) {
    String title = achievementView.result
        ? "Hedefi tamamlamadınız mı?"
        : "Hedefi Tamamladınız mı?";
    String description = achievementView.result
        ? "Hedefin sonucunu geri almak istediğinizden emin misiniz?"
        : "Hedefi tamamladığınızdan emin misiniz?";

    showAlertDialog(title, description, onAcceptAction: () async {
      if (!achievementView.result) {
        // bu durumda hedefi tamamlamış oluyor
        this
            ._notificationSenderStore
            .sendAchievementDoneNotification(achievementView.parameterName);
        ParameterValue parameterValue = await this
            ._achievementListStore
            .setNewParameterValueAsDefault(NewParameterValueAsDefaultDTO(
                parameterId: achievementView.parameterId,
                userId: achievementView.userId,
                value: achievementView.targetValue));
        await _achievementListStore.updateResultAchievement(
            achievementView.id, true, parameterValue.id);

        this._achievementListStore.setShowCongratulations(true);
        doDelayedTask(() => animationController.forward());
      } else {
        this
            ._notificationSenderStore
            .sendAchievementBackNotification(achievementView.parameterName);
        await this._achievementListStore.setParentParameterValueAsDefault(
              achievementView.userId,
              achievementView.parameterId,
            );
        await _achievementListStore.updateResultAchievement(
            achievementView.id, false, null);
      }
      await _achievementListStore
          .setAchievementList(_userProfileStore.authenticatedUser.id);
    });
  }

  _onDeleteButtonAction(AchievementView achievementView) {
    showAlertDialog("Hedefi Silmek Üzeresiniz",
        "Hedefi silmek istediğinizden emin misiniz?", onAcceptAction: () async {
      await _achievementListStore.deleteAchievement(achievementView.id);
      _achievementListStore
          .setAchievementList(_userProfileStore.authenticatedUser.id);
    });
  }

  _buildCongratulationsLayer() {
    return Observer(builder: (_) {
      return this._achievementListStore.showCongratulations
          ? Positioned.fill(
              child: InkWell(
                onTap: () {
                  this._achievementListStore.setShowCongratulations(false);
                  this.animationController.reset();
                },
                child: Opacity(
                  opacity: .7,
                  child: Container(color: Colors.black),
                ),
              ),
            )
          : Container();
    });
  }

  _buildCongratulationsLayerItem() {
    return Observer(builder: (_) {
      return this._achievementListStore.showCongratulations
          ? Positioned(
              child: AnimatedBackground(
                  behaviour: RandomParticleBehaviour(
                      options: ParticleOptions(
                          image: Image.asset('assets/images/star_stroke.png'),
                          particleCount: 35,
                          opacityChangeRate: 1,
                          maxOpacity: 1,
                          spawnMaxRadius: 25,
                          spawnMinRadius: 10,
                          minOpacity: .2)),
                  vsync: this,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: AnimatedBuilder(
                          animation: animationController,
                          child: Icon(
                            Icons.done_outline,
                            size: this.calIconSize(IconSizeType.xxMega),
                            color: Colors.white,
                          ),
                          builder: (BuildContext context, Widget _widget) {
                            return Transform.scale(
                              scale: animation.value,
                              child: Transform.rotate(
                                angle: animation.value * 6.3,
                                child: _widget,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: this.calSizeForDevice(20),
                      ),
                      Center(
                        child: Text(
                          "Tebrikler, başardınız!",
                          style: TextStyles.xxLargeText.whiteColor().ok(),
                        ),
                      )
                    ],
                  )))
          : Container();
    });
  }
}
