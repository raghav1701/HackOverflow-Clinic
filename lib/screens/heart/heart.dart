import 'package:bug_busters/models/heart.dart';
import 'package:bug_busters/screens/heart/form.dart';
import 'package:bug_busters/screens/heart/result.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:flutter/material.dart';

class HeartTest extends StatefulWidget {

  @override
  _HeartTestState createState() => _HeartTestState();
}

class _HeartTestState extends State<HeartTest> {
  HeartTestModel heartTestData = HeartTestModel();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void saveFormData() {
    if(!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HeartTestResults(heartTestData: heartTestData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Test'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
                child: HeartForm(
                  name                : (value) => heartTestData.name           = value,
                  age                 : (value) => heartTestData.age            = int.parse(value),
                  gender              : (value) => heartTestData.gender         = value[0],
                  chestPain           : (value) => heartTestData.chestPain      = value,
                  bloodPressure       : (value) => heartTestData.bloodPressure  = double.parse(value),
                  cholestrol          : (value) => heartTestData.cholestrol     = double.parse(value),
                  sugar               : (value) => heartTestData.sugar          = double.parse(value),
                  electrocardiographic: (value) => heartTestData.electrocardiographic = value,
                  maxHeart            : (value) => heartTestData.maxHeart       = double.parse(value),
                  angina              : (value) => heartTestData.angina         = value == 'Yes' ? true : false,
                  stDepression        : (value) => heartTestData.stDepression   = double.parse(value),
                  slope               : (value) => heartTestData.slope          = value,
                  bloodVessels        : (value) => heartTestData.bloodVessels   = int.parse(value),
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
          ),
        ),
      ),
    );
  }
}
