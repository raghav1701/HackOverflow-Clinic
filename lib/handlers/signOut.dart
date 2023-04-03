import 'package:bug_busters/services/firestore.dart';
import 'package:bug_busters/shared/routes.dart';
import 'package:bug_busters/widgets/confirm_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void handleSignOut(BuildContext context, Function waiting) async {
  waiting(true);
  await Provider.of<FirestoreService>(context, listen: false).signOutUser();
  Navigator.pushNamedAndRemoveUntil(context, login, (route) => false);
}

void handleSignOutDialog(BuildContext context, Function loading) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
        content: Text(
          'You are about to sign out. Confirm?',
          textAlign: TextAlign.justify,
        ),
        actions: [
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
            child: Text('Sign Out'),
            onPressed: () => handleSignOut(context, loading),
          ),
          SizedBox(
            width: 4.0,
          ),
        ],
      );
    }
  );
}

void handleSignOutBottomSheet(BuildContext context, Function loading) async {
  showModalBottomSheet(
    context: context,
    builder: (context2) => ConfirmUserAction(
      confirm: () => handleSignOut(context, loading),
      title: 'Confirm Sign Out',
    ),
  );
}
