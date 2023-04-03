import 'dart:convert';
import 'package:bug_busters/models/app.dart';
import 'package:bug_busters/models/sugar.dart';
import 'package:bug_busters/screens/result_123.dart';
import 'package:flutter/material.dart';

class SugarTestResults extends StatelessWidget {
  const SugarTestResults({this.sugarTestData, this.displayOnly = false});

  final SugarTestModel sugarTestData;
  final bool displayOnly;

  @override
  Widget build(BuildContext context) {
    Map<String, String> data = {
      'name'      : sugarTestData.name,
      'Age'       : sugarTestData.age.toString(),
      'Gender'    : sugarTestData.gender == 'M' ? 'Male' : 'Female',
      'Pregnacies': sugarTestData.pregnancies.toString(),
      'Glucose'   : sugarTestData.glucose.toString(),
      'Blood Pressure' : sugarTestData.bloodPressure.toString(),
      'Insulin'   : sugarTestData.insulin.toString(),
      'Height'    : sugarTestData.height.toString(),
      'Weight'    : sugarTestData.weight.toString(),
      'father'    : sugarTestData.parents[0] == true ? 'yes' : 'no',
      'mother'    : sugarTestData.parents[1] == true ? 'yes' : 'no',
      'gfather'   : sugarTestData.parents[2] == true ? 'yes' : 'no',
      'gmother'   : sugarTestData.parents[3] == true ? 'yes' : 'no',
      'mgfather'  : sugarTestData.parents[4] == true ? 'yes' : 'no',
      'mgmother'  : sugarTestData.parents[5] == true ? 'yes' : 'no',
    };

    String body = json.encode(data);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sugar Test Results',
        ),
      ),

      body: TestResultsBody(
        body: body,
        displayOnly: displayOnly,
        object: sugarTestData,
        type: 3,
        url: RestAPI.sugarURL,
      ),
    );
  }
}
