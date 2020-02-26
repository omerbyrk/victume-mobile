import 'package:victume_mobile/constants/app_theme.dart';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/models/widget/Message.dart';
import 'package:victume_mobile/stores/message/message_store.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageTextField extends StatefulWidget {
  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  MessageStore _messageStore;
  TextEditingController _textEditingController = new TextEditingController();
  FocusNode _textFocusNode = FocusNode();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _messageStore = Provider.of<MessageStore>(context, listen: false);
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
          hintText: "Type something...",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 15.0,
          ),
          suffixIcon: Material(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Colors.transparent,
            child: IconButton(
              icon: Icon(Icons.send),
              color: Colors.black54,
              onPressed: () {
                if (_textEditingController.text.isNotEmpty) {
                  this._messageStore.send(Message(
                      message: _textEditingController.text,
                      type: MessageCardType.SENDER));
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
