import 'package:bug_busters/models/app.dart';
import 'package:bug_busters/shared/constants.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:bug_busters/widgets/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  final bool loading;
  final Function retry;

  Splash({@required this.loading, @required this.retry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      color: kThemeGroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Container(),
          Flexible(
            child: Image.asset(
              kAppLogo,
              fit: BoxFit.cover,
            ),
          ),
          Visibility(
            visible: loading,
            child: Loading(
              color: Color(0xff0049BC),
            ),
            replacement: SubmitButton(
              borderColor: Colors.red,
              textColor: Colors.redAccent,
              onPressed: retry,
              title: 'Retry',
            ),
          ),
          Text(
            'Team\n${AppDetails.team}',
            textAlign: TextAlign.center,
            style: kTeamLogoTextStyle,
          ),
        ],
      ),
    );
  }
}
