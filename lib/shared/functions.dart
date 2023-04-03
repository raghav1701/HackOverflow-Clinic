import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:bug_busters/models/message.dart';

/// As the name suggests this function will check for internet connectivity
///
/// Important: this function can also return error message in case of slow internet connection like 200kbps
Future<ResultMessage> checkInternetConnectivity() async {
  try {
    final result = await InternetAddress.lookup('google.com').timeout(Duration(seconds: 4));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
      return ResultMessage(code: '1', message: 'Connected to Internet');
    return ResultMessage(code: '2', message: 'No Internet Connection');
  } on TimeoutException catch (_) {
    return ResultMessage(code: '3', message: 'Connection Timeout');
  } on SocketException catch (_) {
    return ResultMessage(code: '4', message: 'No Internet Connection');
  } on PlatformException catch (e) {
    return ResultMessage(code: '2', message: e.message ?? 'No Internet Connection');
  } catch (_) {
    return ResultMessage(code: '5', message: 'Unknown error caught while connecting to internet');
  }
}

String convertTimestampToDateTime(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String result = '';
  if (dateTime.day < 10)
    result += '0';
  result += dateTime.day.toString() + '-';

  if (dateTime.month < 10)
    result += '0';
  result += dateTime.month.toString() + '-';

  result += dateTime.year.toString() + ' | ';

  if (dateTime.hour < 10)
    result += '0';
  result += dateTime.hour.toString() + ':';

  if (dateTime.minute < 10)
    result += '0';
  result += dateTime.minute.toString();

  return result;
}
