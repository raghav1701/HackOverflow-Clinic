import 'dart:convert';
import 'package:bug_busters/models/app.dart';
import 'package:bug_busters/models/heart.dart';
import 'package:bug_busters/screens/result_123.dart';
import 'package:flutter/material.dart';

class HeartTestResults extends StatelessWidget {
  const HeartTestResults({this.heartTestData, this.displayOnly = false});

  final HeartTestModel heartTestData;
  final bool displayOnly;

  @override
  Widget build(BuildContext context) {
    Map<String, String> data = {
      'name'                            : heartTestData.name,
      'Age'                             : heartTestData.age.toString(),
      'Gender'                          : heartTestData.gender == 'M' ? 'Male' : 'Female',
      'Chest Pain'                      : heartTestData.chestPain,
      'Resting Blood Pressure'          : heartTestData.bloodPressure.toString(),
      'Cholesterol'                     : heartTestData.cholestrol.toString(),
      'Fasting blood Sugar'             : heartTestData.sugar.toString(),
      'Resting Electrocardiographic Result':heartTestData.electrocardiographic,
      'Maximum heart rate achieved'     : heartTestData.maxHeart.toString(),
      'Exercise induced Angina'         : heartTestData.angina ? 'Yes' : 'No',
      'ST depression induced by exercise':heartTestData.stDepression.toString(),
      'Slope'                           : heartTestData.slope,
      'Number of major blood vessels'   : heartTestData.bloodVessels.toString(),
    };

    String body = json.encode(data);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Heart Test Results',
        ),
      ),

      body: TestResultsBody(
        body: body,
        displayOnly: displayOnly,
        object: heartTestData,
        type: 1,
        url: RestAPI.heartURL,
      ),
    );
  }
}
