import 'package:flutter/material.dart';
import 'package:bug_busters/themes/decoration.dart';

class ConfirmUserAction extends StatelessWidget {
  ConfirmUserAction({@required this.confirm, @required this.title});

  /// Function to be trigger when action is confirmed
  final Function confirm;

  /// `Title` to be displayed in the first field as confirm action
  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
              child: Text(
                title,
                style: kDefaultTextStyleLarge.copyWith(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              onPressed: confirm,
            ),
            Divider(
              height: 0.0,
              indent: 20.0,
              endIndent: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Text(
                'Cancel',
                style: kDefaultTextStyleLarge,
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
