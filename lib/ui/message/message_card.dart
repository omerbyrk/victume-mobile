import 'package:victume_mobile/constants/app_theme.dart';
import 'package:victume_mobile/constants/enums.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final String message;
  final MessageCardType type;

  const MessageCard({Key key, this.message, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == MessageCardType.RECEIVER ? this._buildReceivedMessageCard() : this._buildSendedMessageCard();
  }


    _buildSendedMessageCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Flexible(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(width: 1.0, color: AppColors.purple[600])),
            color: AppColors.purple[300],
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Text(
                message,
                style: TextStyles.middleText.isBolder().ok(), textAlign: TextAlign.justify,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildReceivedMessageCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Flexible(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(width: 1.0, color: Colors.black26)),
            color: Colors.white70,
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Text(
                message,
                style: TextStyles.middleText.isBolder().ok(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
