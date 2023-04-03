import 'package:bug_busters/models/ear.dart';
import 'package:bug_busters/screens/result_45.dart';
import 'package:bug_busters/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EarTestResults extends StatelessWidget {
  const EarTestResults({this.earTestData, this.displayOnly = false});

  final EarTestModel earTestData;
  final bool displayOnly;

  @override
  Widget build(BuildContext context) {

    earTestData.name = Provider.of<FirestoreService>(context, listen: false).name;
    earTestData.age = Provider.of<FirestoreService>(context, listen: false).age;
    earTestData.gender = Provider.of<FirestoreService>(context, listen: false).gender;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ear Test Results',
        ),
      ),

      body: TestResultsBody(
        displayOnly: displayOnly,
        object: earTestData,
        type: 5,
      ),
    );
  }
}
