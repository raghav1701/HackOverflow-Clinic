import 'package:bug_busters/handlers/dialog.dart';
import 'package:bug_busters/models/sugar.dart';
import 'package:bug_busters/screens/sugar/form.dart';
import 'package:bug_busters/screens/sugar/result.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:flutter/material.dart';

class SugarTest extends StatefulWidget {
  @override
  _SugarTestState createState() => _SugarTestState();
}

class _SugarTestState extends State<SugarTest> {

  int page = 1;

  SugarTestModel sugarTestData = SugarTestModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> questions = [
    'Does your father has diabetes?',
    'Does your mother has diabetes?',
    'Does your paternal grandfather has diabetes?',
    'Does your paternal grandmother has diabetes?',
    'Does your maternal grandfather has diabetes?',
    'Does your maternal grandmother has diabetes?',
  ];

  void saveFormData() {
    if(!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    setState(() => page = 2);
  }

  void submitFormData() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SugarTestResults(sugarTestData: sugarTestData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sugar Test'),
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
          child: page == 1 ? _buildPageOne(context) : _buildPageTwo(context)
        ),
      ),

      floatingActionButton: page != 2 ? null : SubmitButton(
        title: 'Submit',
        onPressed: submitFormData,
      ),
    );
  }

  Widget _buildPageOne(BuildContext context) {
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
          child: SugarTestForm(
            name        : (value) => sugarTestData.name         = value,
            age         : (value) => sugarTestData.age          = int.parse(value),
            gender      : (value) => sugarTestData.gender       = value[0],
            pregnancies : (value) => sugarTestData.pregnancies  = value,
            glucose     : (value) => sugarTestData.glucose      = double.parse(value),
            bloodPressure:(value) => sugarTestData.bloodPressure= double.parse(value),
            insulin     : (value) => sugarTestData.insulin      = double.parse(value),
            height      : (value) => sugarTestData.height       = double.parse(value),
            weight      : (value) => sugarTestData.weight       = double.parse(value),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SubmitButton(
              title: 'Next',
              onPressed: saveFormData,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPageTwo(BuildContext context) {
    return Column(
      children: [
        Text(
          'Tick the relevant check boxes-',
          style: kDefaultTextStyleExtraLarge.copyWith(
            color: Colors.black87,
            fontFamily: 'Aclonica',
          ),
        ),
      ]..addAll(questions.asMap().entries.map((entry) {
        return CheckboxListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          title: Text('${entry.value}'),
          value: sugarTestData.parents[entry.key],
          onChanged: (value) => setState(() => sugarTestData.parents[entry.key] = value),
        );
      }).toList()),
    );
  }
}
