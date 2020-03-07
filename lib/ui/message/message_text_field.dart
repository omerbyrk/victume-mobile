import 'package:victume_mobile/main.dart';
import 'package:victume_mobile/stores/user_profile/user_profile_message_store.dart';
import 'package:victume_mobile/ui/ScreenStatefulBase.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {

  MessageTextField();

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends ScreenStatefulBase<MessageTextField> {
  TextEditingController _textEditingController = new TextEditingController();
  UserProfileMessageStore _messageContainerController =
      appComponent.getUserProfileMessageStore();
  FocusNode _textFocusNode = FocusNode();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                elevation: 5.0,
                child: _buildTextField(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildTextField() {
    return TextField(
        style: TextStyles.largeText.blackColor().ok(),
        controller: _textEditingController,
        autofocus: false,
        focusNode: _textFocusNode,
        textInputAction: TextInputAction.send,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Mesajınızı yazınız...",
          contentPadding: EdgeInsets.symmetric(
            horizontal: this.calSizeForDevice(16.0),
            vertical: this.calSizeForDevice(15.0),
          ),
          suffixIcon: Material(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Colors.transparent,
            child: IconButton(
              icon: Icon(Icons.send),
              color: Colors.black54,
              onPressed: () async {
                if (_textEditingController.text.isNotEmpty) {
                  await this
                      ._messageContainerController
                      .sendMessageToMentor(_textEditingController.text);
                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => _textEditingController.clear());
                }
              },
            ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.black)),
        ));
  }
}
