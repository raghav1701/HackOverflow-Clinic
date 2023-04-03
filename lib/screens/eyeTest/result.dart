import 'package:bug_busters/models/eye.dart';
import 'package:bug_busters/screens/result_45.dart';
import 'package:bug_busters/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestResults extends StatelessWidget {
  const TestResults({this.eyeTestData, this.displayOnly = false});

  final EyeTestModel eyeTestData;
  final bool displayOnly;

  @override
  Widget build(BuildContext context) {

    eyeTestData.name = Provider.of<FirestoreService>(context, listen: false).name;
    eyeTestData.age = Provider.of<FirestoreService>(context, listen: false).age;
    eyeTestData.gender = Provider.of<FirestoreService>(context, listen: false).gender;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eye Test Results',
        ),
      ),

      body: TestResultsBody(
        displayOnly: displayOnly,
        object: eyeTestData,
        type: 4,
      ),
    );
  }
}
