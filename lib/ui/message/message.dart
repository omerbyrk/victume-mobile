import 'package:victume_mobile/constants/app_theme.dart';
import 'package:victume_mobile/stores/message/message_store.dart';
import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:victume_mobile/ui/message/message_card.dart';
import 'package:victume_mobile/ui/message/message_text_field.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({Key key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends ScreenStatefulBase<MessageScreen> {
  MessageStore _messageStore = MessageStore();
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<MessageStore>(
      create: (_) => _messageStore,
      child: Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: AppColors.green[100],
        body: _buildBody(),
      ),
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
            size: this.calSizeForDevice( 30),
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 10,
        )
      ],
      title: Row(
        children: <Widget>[
          Icon(
            Icons.lens,
            color: Colors.grey[600],
            size: this.calSizeForDevice(12),
          ),
          SizedBox(
            width: this.calSizeForDevice(10.0),
          ),
          Text("Dyt. Elif Marangoz",
              style: TextStyles.xLargeText.whiteColor().isBolder().ok()),
        ],
      ),
    );
  }

  _buildBody() {
    return Column(
      children: <Widget>[_buildBodyTop(), _buildBodyBottom()],
    );
  }

  _buildBodyTop() {
    return Flexible(
      fit: FlexFit.tight,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Observer(
            builder: (_) {
              _scrollToDown();
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Column(
                  children: <Widget>[
                    ..._messageStore.messageList.map((message) => MessageCard(
                        message: message.message, type: message.type))
                  ],
                ),
              );
            }),
      ),
    );
  }

  _scrollToDown() {
    doDelayedTask(() => {
          _scrollController.jumpTo(
            _scrollController.position.maxScrollExtent,
          )
        });
  }

  _buildBodyBottom() {
    return MessageTextField();
  }
}
