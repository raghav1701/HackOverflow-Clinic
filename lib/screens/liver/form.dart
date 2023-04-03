import 'package:bug_busters/services/firestore.dart';
import 'package:bug_busters/shared/validator.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LiverTestForm extends StatefulWidget {
  const LiverTestForm({
    @required this.name,
    @required this.age,
    @required this.gender,
    @required this.totalBilirubin,
    @required this.directBilirubin,
    @required this.phosphate,
    @required this.alamine,
    @required this.aspartate,
    @required this.protein,
    @required this.albumin,
    @required this.albuminByGlobulin,
  });

  final Function name;
  final Function age;
  final Function gender;
  final Function totalBilirubin;
  final Function directBilirubin;
  final Function phosphate;
  final Function alamine;
  final Function aspartate;
  final Function protein;
  final Function albumin;
  final Function albuminByGlobulin;

  @override
  _LiverTestFormState createState() => _LiverTestFormState();
}

class _LiverTestFormState extends State<LiverTestForm> {
  final double gap = 18.0;

  bool isUserPatient;

  String gender;
  List<String> genderList;

  TextEditingController nameFieldController = TextEditingController();
  TextEditingController ageFieldController = TextEditingController();

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
          readOnly: isUserPatient,
          validator: validateName,
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
          readOnly: isUserPatient,
          validator: validateStringIsDouble,
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
          value: gender,
          validator: requiredFormField,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Total Bilirubin (mg/dl)',
          ),
          onSaved: widget.totalBilirubin,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Direct Bilirubin (mg/dl)',
          ),
          onSaved: widget.directBilirubin,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Alkaline Phosphate (IU/L)',
          ),
          onSaved: widget.phosphate,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Alamine Aminotransferase (IU/L)',
          ),
          onSaved: widget.alamine,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Aspartate Aminotransferase (IU/L)',
          ),
          onSaved: widget.aspartate,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Total Protein (g/dL)',
          ),
          onSaved: widget.protein,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Albumin (g/dL)',
          ),
          onSaved: widget.albumin,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Albumin : Globulin (Ratio)',
          ),
          onSaved: widget.albuminByGlobulin,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
      ],
    );
  }
}
