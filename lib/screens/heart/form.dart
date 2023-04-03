import 'package:bug_busters/services/firestore.dart';
import 'package:bug_busters/shared/validator.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeartForm extends StatefulWidget {
  const HeartForm({
    @required this.name,
    @required this.age,
    @required this.gender,
    @required this.chestPain,
    @required this.bloodPressure,
    @required this.cholestrol,
    @required this.sugar,
    @required this.electrocardiographic,
    @required this.maxHeart,
    @required this.angina,
    @required this.stDepression,
    @required this.slope,
    @required this.bloodVessels,
  });

  final Function name;
  final Function age;
  final Function gender;
  final Function chestPain;
  final Function bloodPressure;
  final Function cholestrol;
  final Function sugar;
  final Function electrocardiographic;
  final Function maxHeart;
  final Function angina;
  final Function stDepression;
  final Function slope;
  final Function bloodVessels;

  @override
  _HeartFormState createState() => _HeartFormState();
}

class _HeartFormState extends State<HeartForm> {
  final double gap = 18.0;

  bool isUserPatient;

  String gender, chestPain, electrocardiographic, angina, slope, bloodVessels;
  List<String> genderList;
  List<String> chestPainItems = [
    'Asymptomatic',
    'Atypical Angina',
    'Non-Anginal Pain',
    'Typical Angina',
  ];
  List<String> electrocardiographicItems = [
    'Normal',
    'ST-T wave with abnormality',
    'Definite/probable left ventricular hypertrophy',
  ];
  List<String> anginaItems = [
    'Yes',
    'No',
  ];
  List<String> slopeItems = [
    'Upsloping',
    'Flat',
    'Downsloping',
  ];
  List<String> bloodVesselItems = [
    '0',
    '1',
    '2',
    '3',
  ];

  TextEditingController nameFieldController = TextEditingController();
  TextEditingController ageFieldController = TextEditingController();
  TextEditingController pregnancyFieldController = TextEditingController();

  void handleAreYouThePatient(bool value) {
    genderList.clear();
    if (value) {
      setState(() {
        isUserPatient = true;
        nameFieldController.text = Provider.of<FirestoreService>(context, listen: false).name;
        ageFieldController.text = Provider.of<FirestoreService>(context, listen: false).age.toString();
        gender = Provider.of<FirestoreService>(context, listen: false).gender == 'M' ? 'Male' : 'Female';
        genderList.add(gender);
      });
    } else {
      setState(() {
        isUserPatient = false;
        genderList.addAll(['Male', 'Female']);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isUserPatient = false;
    genderList = ['Male', 'Female'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CheckboxListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          onChanged: handleAreYouThePatient,
          title: Text('Are you the patient?'),
          value: isUserPatient,
        ),
        TextFormField(
          controller: nameFieldController,
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Name',
          ),
          onSaved: widget.name,
          validator: validateName,
          readOnly: isUserPatient,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          controller: ageFieldController,
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Age',
          ),
          onSaved: widget.age,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
          readOnly: isUserPatient,
        ),
        SizedBox(
          height: gap,
        ),
        DropdownButtonFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Gender',
          ),
          items: genderList.map((item) => DropdownMenuItem(
            child: Text('$item'),
            value: item,
          )).toList(),
          onChanged: (value) {
            setState(() => gender = value);
          },
          onSaved: widget.gender,
          validator: requiredFormField,
          value: gender,
        ),
        SizedBox(
          height: gap,
        ),
        DropdownButtonFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Chest Pain',
          ),
          items: chestPainItems.map((item) => DropdownMenuItem(
            child: Text('$item'),
            value: item,
          )).toList(),
          onChanged: (value) => setState(() => chestPain = value),
          onSaved: widget.chestPain,
          value: chestPain,
          validator: requiredFormField,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Resting Blood Pressure (Hg)',
          ),
          onSaved: widget.bloodPressure,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Cholestrol (mg/dL)',
          ),
          onSaved: widget.cholestrol,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Fasting Blood Sugar (mg/dL)',
          ),
          onSaved: widget.sugar,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        DropdownButtonFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Resting Electrocardiographic',
          ),
          items: electrocardiographicItems.map((item) => DropdownMenuItem(
            child: Text('$item'),
            value: item,
          )).toList(),
          onChanged: (value) => setState(() => electrocardiographic = value),
          onSaved: widget.electrocardiographic,
          value: electrocardiographic,
          validator: requiredFormField,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Maximum Heart Rate achieved',
          ),
          onSaved: widget.maxHeart,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        DropdownButtonFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Exercise Induces Angina',
          ),
          items: anginaItems.map((item) => DropdownMenuItem(
            child: Text('$item'),
            value: item,
          )).toList(),
          onChanged: (value) => setState(() => angina = value),
          onSaved: widget.angina,
          value: angina,
          validator: requiredFormField,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'ST Depression induced by exercise',
          ),
          onSaved: widget.stDepression,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        DropdownButtonFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Slope',
          ),
          items: slopeItems.map((item) => DropdownMenuItem(
            child: Text('$item'),
            value: item,
          )).toList(),
          onChanged: (value) => setState(() => slope = value),
          onSaved: widget.slope,
          value: slope,
          validator: requiredFormField,
        ),
        SizedBox(
          height: gap,
        ),
        DropdownButtonFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Number of major blood vessels',
          ),
          items: bloodVesselItems.map((item) => DropdownMenuItem(
            child: Text('$item'),
            value: item,
          )).toList(),
          onChanged: (value) => setState(() => bloodVessels = value),
          onSaved: widget.bloodVessels,
          value: bloodVessels,
          validator: requiredFormField,
        ),
        SizedBox(
          height: gap,
        ),
        SizedBox(
          height: 2*gap,
        ),
      ],
    );
  }
}
