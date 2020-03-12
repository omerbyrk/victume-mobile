import 'package:image_picker/image_picker.dart';
import 'package:victume_mobile/constants/app_theme.dart';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';
import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:victume_mobile/utils/HelpfulFunction.dart';
import 'package:victume_mobile/utils/clipper/CustomClipperShape.dart';
import 'package:victume_mobile/utils/clipper/CustomProfilePhotoPainter.dart';
import 'package:victume_mobile/utils/clipper/ProfilPhotoClipperShape.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:victume_mobile/widgets/custom_raised_button.dart';
import 'package:victume_mobile/widgets/custom_rounded_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UserProfileTopWidget extends StatefulWidget {
  UserProfileTopWidget({Key key}) : super(key: key);

  @override
  _UserProfileTopWidgetState createState() => _UserProfileTopWidgetState();
}

class _UserProfileTopWidgetState
    extends ScreenStatefulBase<UserProfileTopWidget> {
  UserProfileStore userProfileStore = appComponent.getUserProfileStore();

  @override
  Widget build(BuildContext context) {
    return _buildTopBody();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildTopBody() {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: this.calHeight(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[AppColors.purple[600], AppColors.purple[800]],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[_bodyTopLeftSide(), _bodyTopRightSide()],
        ),
      ],
    );
  }

  Expanded _bodyTopRightSide() {
    return Expanded(
        flex: 6,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: this.calSizeForDevice(12),
              vertical: this.calSizeForDevice(12.0)),
          height: this.calHeight(40),
          child: Observer(
            builder: (_) => userProfileStore.authUserParameters.length == 0
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...userProfileStore.authUserParameters
                          .where((parameter) => parameter.onProfile)
                          .map((parameter) {
                        return Column(
                          children: <Widget>[
                            CustomRoundedChip(
                              content:
                                  "${parameter.name} ${parameter.parameterValue.value}",
                              iconData: HelpfulFunction.getParameterIcon(
                                  parameter.parameterValue.value),
                            ),
                            SizedBox(
                              height: this.calSizeForDevice(12.0),
                            ),
                          ],
                        );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomRaisedButton(
                            onPressed: () {},
                            gradient: LinearGradient(
                              colors: <Color>[
                                AppColors.orange[700],
                                AppColors.orange[600],
                                AppColors.orange[800],
                              ],
                            ),
                            icon: Icon(
                              Icons.bookmark_border,
                              size: this.calIconSize(IconSizeType.Small),
                              color: Colors.white,
                            ),
                            text: Text(
                              "Başarım",
                              style: TextStyles.smallText
                                  .whiteColor()
                                  .isBolder()
                                  .ok(),
                            ),
                          ),
                          Opacity(
                            opacity: 0.92,
                            child: Chip(
                              backgroundColor: Colors.black.withOpacity(.1),
                              avatar: Icon(
                                Icons.star,
                                size: this.calIconSize(IconSizeType.Small),
                                color: Colors.black,
                              ),
                              label: Text(
                                "9.9",
                                style: TextStyles.smallText
                                    .blackColor()
                                    .isBolder()
                                    .ok(),
                              ),
                              elevation: 5.0,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
          ),
        ));
  }

  doUploadPhoto() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 75,
        maxHeight: 1920,
        maxWidth: 1080);
    if (image != null) {
      userProfileStore.uploadPhoto(image);
    }
  }

  Expanded _bodyTopLeftSide() {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: this.calSizeForDevice(10)),
        child: ClipPath(
          clipper: ProfilPhotoClipperShape(),
          child: Container(
            height: this.calHeight(35),
            child: CustomPaint(
              painter: CustomProfilePhotoPainter(),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: this.calSizeForDevice(10.0),
                  ),
                  Observer(
                    builder: (_) {
                      if (userProfileStore.authenticatedUser?.profile == null)
                        return Container();

                      return Material(
                        elevation: 18,
                        clipBehavior: Clip.antiAlias,
                        shape: CircleBorder(
                            side:
                                BorderSide(color: Colors.black54, width: 2.5)),
                        child: InkWell(
                          onTap: doUploadPhoto,
                          child: Image.network(
                            HelpfulFunction.getFullPhotoPath(
                                userProfileStore
                                    .authenticatedUser?.profile?.photo,
                                userProfileStore
                                    .authenticatedUser?.profile?.fullname),
                            height: this.calHeight(18),
                            width: this.calWidth(36),
                            color: AppColors.purple[500].withOpacity(.15),
                            colorBlendMode: BlendMode.color,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: super.calSizeForDevice(8.0),
                  ),
                  Observer(
                    builder: (_) {
                      if (userProfileStore
                              .authenticatedUser?.profile?.fullname ==
                          null) return Container();

                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: super.calSizeForDevice(12.0)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white.withOpacity(0.5)),
                        padding: EdgeInsets.all(super.calSizeForDevice(4.0)),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              size: this.calIconSize(IconSizeType.Small),
                              color: Colors.black87.withOpacity(.9),
                            ),
                            SizedBox(
                              width: this.calSizeForDevice(2.0),
                            ),
                            Expanded(
                              child: Text(
                                userProfileStore
                                    .authenticatedUser.profile.fullname,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.smallText
                                    .color(Colors.black87)
                                    .isBolder()
                                    .ok(),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
