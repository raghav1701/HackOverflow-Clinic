import 'package:bug_busters/themes/decoration.dart';
import 'package:flutter/material.dart';

class ReportHistoryTile extends StatelessWidget {
  ReportHistoryTile({
    @required this.title,
    @required this.subtitle,
    @required this.action,
  });

  final String title;
  final String subtitle;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 5.0),
      title: Text(title, style: kDefaultTextStyleLarge,),
      subtitle: Text(subtitle),
      onTap: action,
    );
  }
}

class SettingsMenuItemTile extends StatelessWidget {

  SettingsMenuItemTile({
    @required this.title,
    @required this.action,
  });

  final String title;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
      ),
      onTap: action,
    );
  }
}
