import 'package:bug_busters/handlers/dialog.dart';
import 'package:bug_busters/models/liver.dart';
import 'package:bug_busters/screens/liver/form.dart';
import 'package:bug_busters/screens/liver/result.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:flutter/material.dart';

class LiverTest extends StatefulWidget {
  @override
  _LiverTestState createState() => _LiverTestState();
}

class _LiverTestState extends State<LiverTest> {

  LiverTestModel _liverTestData = LiverTestModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void saveFormData() {
    if(!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LiverTestResults(liverTestData: _liverTestData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liver Test'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            handleAlertDialog(
              context: context,
              textContent: 'Are you sure to leave the test in between?',
              actionTitle: 'Leave',
              action: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
          }
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _build(context)
        ),
      ),
    );
  }

  Widget _build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Please fill the form below-',
          style: kDefaultTextStyleExtraLarge.copyWith(
            color: Colors.black87,
            fontFamily: 'Aclonica',
          ),
        ),
        Form(
          key: _formKey,
          child: LiverTestForm(
            name            : (value) => _liverTestData.name            = value,
            age             : (value) => _liverTestData.age             = int.parse(value),
            gender          : (value) => _liverTestData.gender          = value[0],
            totalBilirubin  : (value) => _liverTestData.totalBilirubin  = double.parse(value),
            directBilirubin : (value) => _liverTestData.directBilirubin = double.parse(value),
            phosphate       : (value) => _liverTestData.phosphate       = double.parse(value),
            alamine         : (value) => _liverTestData.alamine         = double.parse(value),
            aspartate       : (value) => _liverTestData.aspartate       = double.parse(value),
            protein         : (value) => _liverTestData.protein         = double.parse(value),
            albumin         : (value) => _liverTestData.albumin         = double.parse(value),
            albuminByGlobulin:(value) => _liverTestData.albuminByGlobulin = double.parse(value),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SubmitButton(
              title: 'Submit',
              onPressed: saveFormData,
            ),
          ],
        ),
      ],
    );
  }
}
