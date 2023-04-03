import 'package:flutter/material.dart';

void handleSnackBar({
  @required BuildContext context,
  @required String message,
  int milliseconds = 4000,
  int seconds = 0,
  int minutes = 0,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(minutes: minutes, seconds: seconds, milliseconds: milliseconds),
  ));
}

void handleSnackBarWithRetry({
  @required BuildContext context,
  @required String message,
  @required Function action,
  int seconds = 0,
  int minutes = 10,
  int hours = 0,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    action: SnackBarAction(
      label: 'RETRY',
      onPressed: action,
    ),
    content: Text(message),
    duration: Duration(hours: hours, minutes: minutes, seconds: seconds),
  ));
}
