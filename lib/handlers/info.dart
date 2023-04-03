import 'package:bug_busters/services/firestore.dart';
import 'package:bug_busters/shared/routes.dart';
import 'package:bug_busters/shared/validator.dart';
import 'package:bug_busters/widgets/confirm_action.dart';
import 'package:bug_busters/widgets/edit_details.dart';
import 'package:bug_busters/widgets/edit_dob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void handleChangeName(BuildContext currentContext, String data) {
  showModalBottomSheet(
    context: currentContext,
    isScrollControlled: true,
    builder: (context) => EditDetailsPane(
      save: (value) async {
        Navigator.pop(context);
        final String result = await Provider.of<FirestoreService>(context, listen: false).changeBasicInfo('name', value);
        try{
          ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(content: Text(result)));
        } catch(_) {}
      },
      maxLength: 20,
      title: 'Enter Your Name',
      hintText: 'Your Name',
      validator: validateName,
      value: data,
    ),
  );
}

void handleChangeDOB(BuildContext currentContext, String data) {
  showModalBottomSheet(
    context: currentContext,
    isScrollControlled: true,
    builder: (context) => EditDateofBirthPane(
      save: (value) async {
        Navigator.pop(context);
        final String result = await Provider.of<FirestoreService>(context, listen: false).changeBasicInfo('dob', value);
        try{
          ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(content: Text(result)));
        } catch(_) {}
      },
      title: 'Enter Your Date of Birth',
      value: data,
    ),
  );
}

void handleChangeEmail(BuildContext currentContext, Function waiting) async {
  final String currentEmail = Provider.of<FirestoreService>(currentContext, listen: false).email;
  String email, password;
  int step = 0;
  await showModalBottomSheet(
    context: currentContext,
    isScrollControlled: true,
    builder: (context) => EditDetailsPane(
      title: 'Change Email',
      hintText: 'Enter New Email',
      save: (value) {
        email = value;
        step = 1;
        Navigator.pop(context);
      },
      validator: validateEmail,
    ),
  );

  if (step == 1) {
  await showModalBottomSheet(
    context: currentContext,
    isScrollControlled: true,
    builder: (context) => EditDetailsPane(
      title: 'Verify Password',
      hintText: 'Enter Current Password',
      secureText: true,
      save: (value) {
        password = value;
        step = 2;
        Navigator.pop(context);
      },
      validator: validatePassword,
    ),
  );

  if (step == 2)
  showModalBottomSheet(
    context: currentContext,
    builder: (context) => ConfirmUserAction(
      title: 'If operation is successful, you will be logged out. Confirm?',
      confirm: () async {
        waiting(true);
        Navigator.pop(context);
        AuthCredential credential = EmailAuthProvider.credential(email: currentEmail, password: password);
        final result = await Provider.of<FirestoreService>(context, listen: false).updateEmail(email, credential);
        if (result.code == '1')
          Navigator.pushNamedAndRemoveUntil(currentContext, login, (route) => false);
        else {
          ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(content: Text(result.message)));
          waiting(false);
        }
      },
    ),
  );
}}

void handleChangePassword(BuildContext currentContext, Function waiting) async {
  final String currentEmail = Provider.of<FirestoreService>(currentContext, listen: false).email;
  String currentPassword, newPassword;
  int step = 0;
  await showModalBottomSheet(
    context: currentContext,
    isScrollControlled: true,
    builder: (context) => EditDetailsPane(
      title: 'Verify Yourself',
      hintText: 'Enter Current Password',
      secureText: true,
      save: (value) {
        currentPassword = value;
        step = 1;
        Navigator.pop(context);
      },
      validator: validatePassword,
    ),
  );
  if (step == 1) {
  await showModalBottomSheet(
    context: currentContext,
    isScrollControlled: true,
    builder: (context) => EditDetailsPane(
      title: 'Enter New Password',
      hintText: 'Enter Password',
      secureText: true,
      save: (value) {
        newPassword = value;
        step = 2;
        Navigator.pop(context);
      },
      validator: validatePassword,
    ),
  );

  if (step == 2)
  showModalBottomSheet(
    context: currentContext,
    builder: (context) => ConfirmUserAction(
      title: 'If operation is successful, you will be logged out. Confirm?',
      confirm: () async {
        waiting(true);
        Navigator.pop(context);
        AuthCredential credential = EmailAuthProvider.credential(email: currentEmail, password: currentPassword);
        final result = await Provider.of<FirestoreService>(context, listen: false).updatePassword(newPassword, credential);
        if (result.code == '1')
          Navigator.pushNamedAndRemoveUntil(currentContext, login, (route) => false);
        else {
          ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(content: Text(result.message)));
          waiting(false);
        }
      },
    ),
  );
}}
