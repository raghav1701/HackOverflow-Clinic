import 'package:bug_busters/themes/decoration.dart';
import 'package:flutter/material.dart';

void handleAlertDialog({
  @required BuildContext context,
  @required String textContent,
  @required String actionTitle,
  @required Function action,
  String title,
  String cancelTitle = "Cancel",
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
        title: title == null ? null : Text(
          '$title',
          style: kDefaultHeaderTextStyle,
        ),
        content: Text(
          '$textContent',
          textAlign: TextAlign.justify,
        ),
        actions: [
          FlatButton(
            child: Text('$cancelTitle'),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
            child: Text('$actionTitle'),
            onPressed: action,
          ),
          SizedBox(
            width: 4.0,
          ),
        ],
      );
    }
  );
}
