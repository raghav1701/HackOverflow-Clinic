import 'package:bug_busters/screens/about.dart';
import 'package:bug_busters/screens/authenticate/login.dart';
import 'package:bug_busters/screens/authenticate/register.dart';
import 'package:bug_busters/screens/dashboard.dart';
import 'package:bug_busters/screens/earTest/eartest.dart';
import 'package:bug_busters/screens/eyeTest/eyetest.dart';
import 'package:bug_busters/screens/heart/heart.dart';
import 'package:bug_busters/screens/history.dart';
import 'package:bug_busters/screens/liver/liver.dart';
import 'package:bug_busters/screens/policy.dart';
import 'package:bug_busters/screens/settings.dart';
import 'package:bug_busters/screens/sugar/sugar.dart';
import 'package:bug_busters/wrapper.dart';
import 'package:flutter/material.dart';

const String wrapper        = '/wrapper';
const String login          = '/login';
const String register       = '/register';
const String addDetails     = '/addDetails';
const String dashboard      = '/dashboard';
const String heartTest      = '/heartTest';
const String liverTest      = '/liverTest';
const String sugarTest      = '/sugarTest';
const String eyeTest        = '/eyeTest';
const String earTest        = '/earTest';
const String resultsScreen  = '/results';
const String aboutUs        = '/aboutus';
const String history        = '/history';
const String policy         = '/policy';
const String settings       = '/settings';

Map<String, WidgetBuilder> routes = {
  wrapper       : (context) => Wrapper(),
  login         : (context) => LoginScreen(),
  register      : (context) => RegistrationScreen(),
  dashboard     : (context) => Dashboard(),
  heartTest     : (context) => HeartTest(),
  liverTest     : (context) => LiverTest(),
  sugarTest     : (context) => SugarTest(),
  eyeTest       : (context) => EyeTest(),
  earTest       : (context) => EarTest(),
  aboutUs       : (context) => AboutUs(),
  history       : (context) => TestsHistory(),
  policy        : (context) => TermsAndConditions(),
  settings      : (context) => SettingsScreen(),
};
