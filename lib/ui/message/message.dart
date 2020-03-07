import 'package:victume_mobile/constants/app_theme.dart';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_message_store.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_store.dart';
import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:victume_mobile/ui/message/message_card.dart';
import 'package:victume_mobile/ui/message/message_text_field.dart';
import 'package:victume_mobile/utils/HelpfulFunction.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({Key key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends ScreenStatefulBase<MessageScreen> {
  UserProfileStore _userProfileStore = appComponent.getUserProfileStore();
  UserProfileMessageStore _messageContainerController =
      appComponent.getUserProfileMessageStore();
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset == 0) {
        _messageContainerController.loadMoreMessage();
      }
    });
    _messageContainerController.onPushedMessage = _scrollToDown;
    _scrollToDown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.green[100],
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 5.0,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        InkWell(
          onTap: () => super.navigatePop(),
          child: Icon(
            Icons.close,
            size: this.calSizeForDevice(30),
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 10,
        )
      ],
      title: Row(
        children: <Widget>[
          Material(
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            shape: CircleBorder(),
            child: Observer(builder: (_) {
              return Image.network(
                HelpfulFunction.getFullPhotoPath(
                    _messageContainerController.mentorProfile.photo, "N"),
                height: 45,
                width: 45,
                color: AppColors.green[600].withOpacity(.15),
                colorBlendMode: BlendMode.color,
                fit: BoxFit.cover,
              );
            }),
          ),
          SizedBox(
            width: this.calSizeForDevice(10.0),
          ),
          Text(_messageContainerController.mentorProfile.fullname,
              style: TextStyles.xLargeText.whiteColor().isBolder().ok()),
        ],
      ),
    );
  }

  _buildBody() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            _buildBodyTop(),
            _buildBodyBottom(),
          ],
        ),
        buildIndicator(_messageContainerController),
        buildUIMessageHandler(_messageContainerController)
      ],
    );
  }

  _buildBodyTop() {
    return Flexible(
      fit: FlexFit.tight,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Observer(builder: (_) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                children: <Widget>[
                  ..._messageContainerController.mentorMessageContainer.messages
                      .map((message) => MessageCard(
                          message: message.message,
                          type: (message.from ==
                                  _userProfileStore.authenticatedUser.id)
                              ? MessageCardType.SENDER
                              : MessageCardType.RECEIVER))
                ],
              ));
        }),
      ),
    );
  }

  _scrollToDown() {
    doDelayedTask(() {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 250), curve: Curves.easeIn);
      _messageContainerController.setMessageAsReadded();
    }, duration: Duration(milliseconds: 100));
  }

  _buildBodyBottom() {
    return MessageTextField();
  }
}
