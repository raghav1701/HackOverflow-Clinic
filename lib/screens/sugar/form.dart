import 'package:bug_busters/services/firestore.dart';
import 'package:bug_busters/shared/validator.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SugarTestForm extends StatefulWidget {
  const SugarTestForm({
    @required this.name,
    @required this.age,
    @required this.gender,
    @required this.pregnancies,
    @required this.glucose,
    @required this.bloodPressure,
    @required this.insulin,
    @required this.height,
    @required this.weight,
  });

  final Function name;
  final Function age;
  final Function gender;
  final Function pregnancies;
  final Function glucose;
  final Function bloodPressure;
  final Function insulin;
  final Function height;
  final Function weight;

  @override
  _SugarTestFormState createState() => _SugarTestFormState();
}

class _SugarTestFormState extends State<SugarTestForm> {
  final double gap = 18.0;

  bool isUserPatient;

  int pregnancies;

  String gender;
  List<String> genderList;

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
        changePregnancies(0);
      });
    } else {
      setState(() {
        isUserPatient = false;
        genderList.addAll(['Male', 'Female']);
      });
    }
  }

  void changePregnancies(int value) {
    if (pregnancies == null) {
      pregnancies = 0;
    }

    if (gender != null && gender == 'Male') {
      pregnancies = 0;
      setState(() => pregnancyFieldController.text = '$pregnancies');
      return;
    }

    pregnancies += value;
    if (pregnancies == -1) {
      pregnancies = 0;
    }

    setState(() => pregnancyFieldController.text = '$pregnancies');
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
            changePregnancies(0);
          },
          onSaved: widget.gender,
          value: gender,
          validator: requiredFormField,
        ),
        SizedBox(
          height: gap,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: kDefaultThemeColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: pregnancyFieldController,
                  decoration: kThemeGroundInputDecoration.copyWith(
                    labelText: 'Pregnancies',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onSaved: (value) => widget.pregnancies(pregnancies),
                  readOnly: true,
                  validator: requiredFormField,
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(FontAwesomeIcons.minus),
                    color: kDefaultThemeColor,
                    onPressed: () => changePregnancies(-1),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.plus),
                    color: kDefaultThemeColor,
                    onPressed: () => changePregnancies(1),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Glucose',
          ),
          onSaved: widget.glucose,
          keyboardType: TextInputType.number,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Blood Pressure (mm Hg)',
          ),
          keyboardType: TextInputType.number,
          onSaved: widget.bloodPressure,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Insulin (mu U/ml)',
          ),
          keyboardType: TextInputType.number,
          onSaved: widget.insulin,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Height (m)',
          ),
          keyboardType: TextInputType.number,
          onSaved: widget.height,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: gap,
        ),
        TextFormField(
          decoration: kThemeGroundInputDecoration.copyWith(
            labelText: 'Weight (kg)',
          ),
          keyboardType: TextInputType.number,
          onSaved: widget.weight,
          validator: validateStringIsDouble,
        ),
        SizedBox(
          height: 2*gap,
        ),
      ],
    );
  }
}
