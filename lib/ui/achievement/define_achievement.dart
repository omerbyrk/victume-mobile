import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/data/AchievementApi.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/stores/achievement/define_achievement_store.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';
import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:victume_mobile/utils/HelpfulFunction.dart';
import 'package:intl/intl.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';

class DefineAchievementScreen extends StatefulWidget {
  Function onDispose;

  DefineAchievementScreen({@required this.onDispose});

  @override
  _DefineAchievementScreenState createState() =>
      _DefineAchievementScreenState();
}

class _DefineAchievementScreenState
    extends ScreenStatefulBase<DefineAchievementScreen> {
  final _formKey = GlobalKey<FormState>();

  UserProfileStore _userProfileStore = appComponent.getUserProfileStore();
  DefineAchievementStore _defineAchievementStore = DefineAchievementStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._buildAppBar(),
      body: this._buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.done_outline,
          size: this.calIconSize(IconSizeType.Large),
          color: Colors.white,
        ),
        onPressed: () {
          bool isValid = this._formKey.currentState.validate();
          if (isValid) {
            _defineAchievementStore.saveOrUpdateAchievement(AchievementDTO(
                parameterId: _defineAchievementStore.formStore.parameterId,
                targetDate: _defineAchievementStore.formStore.targetDate,
                targetValue: _defineAchievementStore.formStore.targetValue,
                currentValue: _userProfileStore
                    .findFromAuthUserParamsBy(
                        _defineAchievementStore.formStore.parameterId)
                    .parameterValue
                    .value,
                parameterValueId: _userProfileStore
                    .findFromAuthUserParamsBy(
                        _defineAchievementStore.formStore.parameterId)
                    .parameterValue
                    .id,
                userId: _userProfileStore.authenticatedUser.id));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    this.widget.onDispose();
    super.dispose();
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
              Icons.star,
              size: this.calIconSize(IconSizeType.Large),
              color: Colors.white,
            ),
            SizedBox(
              width: this.calSizeForDevice(10.0),
            ),
            Expanded(
              child: Text(
                "Hedef Belirle",
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
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildParameterFormField(),
                _buildTargetValueFormField(),
                _buildTargetDateFormField()
              ],
            ),
          ),
        ),
        this.buildIndicator(_defineAchievementStore),
        this.buildUIMessageHandler(_defineAchievementStore)
      ],
    );
  }

  Observer _buildParameterFormField() {
    return Observer(builder: (_) {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: this.calSizeForDevice(10.0),
            vertical: this.calSizeForDevice(20.0)),
        child: DropdownButtonFormField<String>(
          isDense: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Parametre"),
          elevation: 5,
          disabledHint: Text("Parametre Tanımlandı"),
          value: _defineAchievementStore.formStore.parameterId,
          onChanged: this._defineAchievementStore.achievementId == null
              ? (newValue) {
                  this
                      ._defineAchievementStore
                      .formStore
                      .setParameterId(newValue);
                }
              : null,
          validator: (_) =>
              this._defineAchievementStore.formStore.parameterIdValidateText,
          items: _userProfileStore.authUserParameters.map((parameter) {
            return DropdownMenuItem<String>(
                child: Row(
                  children: <Widget>[
                    Icon(HelpfulFunction.getParameterIcon(
                        parameter?.parameterValue?.value)),
                    SizedBox(
                      width: this.calSizeForDevice(10),
                    ),
                    Text(parameter.name)
                  ],
                ),
                value: parameter.id);
          }).toList(),
        ),
      );
    });
  }

  Observer _buildTargetValueFormField() {
    return Observer(builder: (_) {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: this.calSizeForDevice(10.0),
            vertical: this.calSizeForDevice(10.0)),
        child: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Hedef Değer",
              suffixText: "Örnek: $targetValueSuffixText"),
          onChanged: (newValue) {
            this._defineAchievementStore.formStore.setTargetValue(newValue);
          },
          validator: (_) =>
              this._defineAchievementStore.formStore.targetValueValidateText,
        ),
      );
    });
  }

  Container _buildTargetDateFormField() {
    final format = DateFormat("dd/MM/yyyy");
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: this.calSizeForDevice(10.0),
          vertical: this.calSizeForDevice(20.0)),
      child: DateTimeField(
        format: format,
        resetIcon: null,
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: "Hedef Tarih"),
        validator: (_) =>
            _defineAchievementStore.formStore.targetDateValidateText,
        onChanged: (newValue) {
          _defineAchievementStore.formStore.setTargetDate(newValue);
        },
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1995),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    );
  }

  String get targetValueSuffixText {
    var parameter = this._userProfileStore.authUserParameters.firstWhere(
        (parameter) =>
            parameter.id == this._defineAchievementStore.formStore.parameterId,
        orElse: () => this._userProfileStore.authUserParameters.first);
    return parameter?.parameterValue?.value ?? "60kg";
  }
}
