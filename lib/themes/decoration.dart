import 'package:flutter/material.dart';

const kDefaultThemeColor = Color(0xff60b07f);

const kThemeGroundColor = Colors.white;

const kErrorMessageTextStyle = TextStyle(
  color: Colors.red,
  fontSize: 12.0,
  decoration: TextDecoration.none,
);

const kDefaultHeaderTextStyle = TextStyle(
  color: Colors.black,
  decoration: TextDecoration.none,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

const kDefaultTextStyle = TextStyle(
  color: Colors.black,
  decoration: TextDecoration.none,
  fontSize: 16.0,
);

const kDefaultTextStyleLarge = TextStyle(
  color: Colors.black,
  decoration: TextDecoration.none,
  fontSize: 18.0,
);

const kDefaultTextStyleExtraLarge = TextStyle(
  color: Colors.black,
  decoration: TextDecoration.none,
  fontSize: 20.0,
);

const kDefaultTextStyleBold = TextStyle(
  color: Colors.black,
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

const kDefaultAppHeaderTextStyle = TextStyle(
  color: Colors.black,
  decoration: TextDecoration.none,
  fontSize: 24.0,
  fontFamily: 'Aclonica',
  letterSpacing: 1.5,
);

const kTeamLogoTextStyle = TextStyle(
  color: Colors.black87,
  decoration: TextDecoration.none,
  fontFamily: 'Aclonica',
  fontSize: 18.0,
  letterSpacing: 1.0,
);

const kThemeGroundInputDecoration = InputDecoration(
  filled: true,
  fillColor: kThemeGroundColor,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: kDefaultThemeColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDefaultThemeColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDefaultThemeColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  hintStyle: TextStyle(color: Colors.grey),
  labelStyle: TextStyle(color: Colors.grey),
);
