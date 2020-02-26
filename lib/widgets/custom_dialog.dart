import 'package:victume_mobile/constants/app_theme.dart';
import 'package:victume_mobile/utils/textstyle/TextStyles.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, description;
  final Function onAcceptAction, onRejectAction;

  CustomDialog(
      {@required this.title,
      @required this.description,
      this.onAcceptAction,
      this.onRejectAction});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _buildDialogBody(context),
    );
  }

  _buildDialogBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text(
              title,
              style: TextStyles.largeText.isBolder().ok(),
            ),
          ),
          Divider(
            color: AppColors.green[500],
          ),
          SizedBox(height: 5.0),
          Text(description, style: TextStyles.smallText.isBolder().ok()),
          SizedBox(height: 5.0),
          Divider(
            color: AppColors.green[500],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {
                  if (this.onRejectAction != null) this.onRejectAction();
                  Navigator.of(context).pop();
                },
                label: Text(
                  "Hayır",
                  style: TextStyles.smallText.isBolder().ok(),
                ),
              ),
              FlatButton.icon(
                icon: Icon(Icons.done, color: Colors.green),
                onPressed: () {
                  if (this.onAcceptAction != null) this.onAcceptAction();
                  Navigator.of(context).pop();
                },
                label: Text(
                  "Evet",
                  style: TextStyles.smallText.isBolder().ok(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
