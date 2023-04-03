import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bug_busters/themes/decoration.dart';

class CenterHeaderText extends StatelessWidget {
  CenterHeaderText(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title',
        style: kDefaultHeaderTextStyle,
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final Color color;

  Loading({this.color = kDefaultThemeColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitChasingDots(
        color: color,
      ),
    );
  }
}
