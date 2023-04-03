import 'dart:ui';

import 'package:bug_busters/themes/decoration.dart';
import 'package:flutter/material.dart';

/// `Default Light Theme` with custom changes
final ThemeData kdefaultTheme = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(
    centerTitle: false,
    color: kDefaultThemeColor,
    textTheme: TextTheme(
      headline6: TextStyle(
        fontFamily: 'Aclonica',
        fontSize: 20.0,
      ),
    ),
  ),

  backgroundColor: kThemeGroundColor,

  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: kDefaultThemeColor,
    selectedIconTheme: IconThemeData(
      color: kDefaultThemeColor,
    ),
    selectedLabelStyle: TextStyle(
      color: kDefaultThemeColor,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.grey,
    ),
    unselectedLabelStyle: TextStyle(
      color: Colors.grey,
    ),
    type: BottomNavigationBarType.fixed,
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
    backgroundColor: kDefaultThemeColor,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kThemeGroundColor,
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    hintStyle: TextStyle(color: Colors.grey),
    labelStyle: TextStyle(color: Colors.grey),
  ),

  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(Colors.white),
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: Color(0xff323232),
    behavior: SnackBarBehavior.floating,
    actionTextColor: Colors.purple,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  ),

  scaffoldBackgroundColor: Colors.white,

  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.black54),
    subtitle1: TextStyle(color: Colors.black54),
  ),
);
