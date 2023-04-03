import 'dart:convert';

import 'package:bug_busters/models/app.dart';
import 'package:bug_busters/models/liver.dart';
import 'package:bug_busters/screens/result_123.dart';
import 'package:flutter/material.dart';

class LiverTestResults extends StatelessWidget {
const LiverTestResults({this.liverTestData, this.displayOnly = false});

  final LiverTestModel liverTestData;
  final bool displayOnly;

  @override
  Widget build(BuildContext context) {
    Map<String, String> data = {
      'name'                      : liverTestData.name,
      'Age'                       : liverTestData.age.toString(),
      'Gender'                    : liverTestData.gender == 'M' ? 'Male' : 'Female',
      'Total Bilirubin'           : liverTestData.totalBilirubin.toString(),
      'Direct Bilirubin'          : liverTestData.directBilirubin.toString(),
      'Alkaline Phosphate'        : liverTestData.phosphate.toString(),
      'Alamine Aminotransferase'  : liverTestData.alamine.toString(),
      'Aspartate Aminotransferase': liverTestData.aspartate.toString(),
      'Total Protein'             : liverTestData.protein.toString(),
      'Albumin'                   : liverTestData.albumin.toString(),
      'Albumin : Globulin Ratio'  : liverTestData.albuminByGlobulin.toString(),
    };

    String body = json.encode(data);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liver Test Results',
        ),
      ),

      body: TestResultsBody(
        body: body,
        displayOnly: displayOnly,
        object: liverTestData,
        type: 2,
        url: RestAPI.liverURL,
      ),
    );
  }
}
