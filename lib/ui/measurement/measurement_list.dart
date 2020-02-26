import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/models/api/UserFile.dart';
import 'package:victume_mobile/stores/measurement/measurement_list_store.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';
import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:victume_mobile/utils/HelpfulFunction.dart';
import 'package:victume_mobile/utils/TimeAgoHelper.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:path_provider/path_provider.dart';

class MeasurementListScreen extends StatefulWidget {
  @override
  _MeasurementListScreenState createState() => _MeasurementListScreenState();
}

class _MeasurementListScreenState
    extends ScreenStatefulBase<MeasurementListScreen> {
  UserProfileStore _userProfileStore = appComponent.getUserProfileStore();
  MeasurementListStore _measurementListStore = new MeasurementListStore();

  @override
  void initState() {
    super.initState();
    _measurementListStore
        .setMeasurementList(_userProfileStore.authenticatedUser.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  doUploadMeasurement() async {
    var measurement = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 75,
        maxHeight: 1920,
        maxWidth: 1080);
    if (measurement != null) {
      await _measurementListStore.uploadMeasurement(
          _userProfileStore.authenticatedUser.id, measurement);
      _measurementListStore
          .setMeasurementList(_userProfileStore.authenticatedUser.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._buildAppBar(),
      body: this._buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this.doUploadMeasurement();
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
              Icons.image,
              size: this.calIconSize(IconSizeType.Large),
              color: Colors.white,
            ),
            SizedBox(
              width: this.calSizeForDevice(10.0),
            ),
            Expanded(
              child: Text(
                "Ölçümlerim",
                overflow: TextOverflow.ellipsis,
                style: TextStyles.xLargeText.whiteColor().isBolder().ok(),
              ),
            )
          ],
        ));
  }

  _buildBody() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Observer(
              builder: (_) {
                return Expanded(
                  child: this._measurementListStore.isReadyMeasurementList
                      ? ListView.separated(
                          separatorBuilder: (_, index) {
                            return Divider(height: 1);
                          },
                          itemBuilder: (_, index) {
                            UserFile userFile =
                                _measurementListStore.measurementList[index];
                            return ListTile(
                              title: Text(
                                "${index + 1}. Ölçüm Dosyanız",
                                style: TextStyles.smallText.isBolder().ok(),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                  TimeAgoHelper.timeAgo(userFile.createdDate)),
                              leading: Icon(
                                Icons.image,
                                size: this.calIconSize(IconSizeType.Normal),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(
                                        Icons.file_download,
                                        size: this
                                            .calIconSize(IconSizeType.Normal),
                                        color: Colors.blue[300],
                                      ),
                                      onPressed: () async {
                                      }),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: this
                                            .calIconSize(IconSizeType.Normal),
                                        color: Colors.red[300],
                                      ),
                                      onPressed: () async {
                                        await _measurementListStore
                                            .deleteMeasurement(userFile.id);
                                        _measurementListStore
                                            .setMeasurementList(
                                                _userProfileStore
                                                    .authenticatedUser.id);
                                      }),
                                ],
                              ),
                            );
                          },
                          itemCount:
                              this._measurementListStore.measurementList.length)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                "Henüz hiç ölçüm eklenmemiş",
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
        this.buildIndicator(_measurementListStore),
        this.buildUIMessageHandler(_measurementListStore),
      ],
    );
  }
}
