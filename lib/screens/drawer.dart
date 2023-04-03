import 'package:bug_busters/handlers/dialog.dart';
import 'package:bug_busters/handlers/signOut.dart';
import 'package:bug_busters/models/app.dart';
import 'package:bug_busters/services/firestore.dart';
import 'package:bug_busters/shared/constants.dart';
import 'package:bug_busters/shared/routes.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AppDrawer extends Drawer {
  final List<String> drawerItems = [
    'About Us',
    'History',
    'Settings',
    'T&C',
    'Sign Out',
    'Exit',
  ];

  final List<IconData> icon = [
    Icons.info,
    Icons.book,
    Icons.settings,
    Icons.privacy_tip,
    Icons.exit_to_app,
    Icons.power_settings_new,
  ];

  final List<String> routes = [
    aboutUs,
    history,
    settings,
    policy,
  ];

  void tilesAction(BuildContext context, int index) {
    if (index == drawerItems.length - 1) {
      Navigator.pop(context);
      handleAlertDialog(
        context: context,
        textContent: 'You are about to close the app. Confirm?',
        actionTitle: 'Exit',
        action: () => SystemNavigator.pop(),
      );
    } else if (index == drawerItems.length - 2) {
      Navigator.pop(context);
      handleSignOutDialog(context, (value) {});
    } else {
      Navigator.pushNamed(context, routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {

    final String name = Provider.of<FirestoreService>(context).name;
    final int age = Provider.of<FirestoreService>(context).age;
    final String gender = Provider.of<FirestoreService>(context).gender;

    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Row(
                children: [
                  Image.asset(
                    kAppIcon,
                    width: 30,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '${AppDetails.name}',
                    style: kDefaultTextStyleExtraLarge.copyWith(
                      fontFamily: 'Aclonica',
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 0.0,
              thickness: 0.4,
            ),
            ListTile(
              title: Text(
                '$name',
                style: kDefaultTextStyle.copyWith(
                  color: Color(0xaa000000),
                ),
              ),
              subtitle: Text(
                '$gender $age',
                style: kDefaultTextStyle.copyWith(
                  color: Color(0xaa000000),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 0.0,
              thickness: 0.4,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: drawerItems.length,
                separatorBuilder: (context, _) => Divider(
                  height: 0.0,
                  thickness: 0.2,
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      drawerItems[index],
                      style: kDefaultTextStyle.copyWith(
                        color: Color(0xaa000000),
                      ),
                    ),
                    leading: Icon(icon[index]),
                    onTap: () => tilesAction(context, index),
                  );
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Text(
                'Team\n${AppDetails.team}',
                style: kTeamLogoTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
