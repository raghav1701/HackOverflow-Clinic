import 'package:bug_busters/themes/decoration.dart';
import 'package:flutter/material.dart';
import 'package:bug_busters/shared/validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrationForm extends StatefulWidget {
  RegistrationForm({
    @required this.name,
    @required this.dob,
    @required this.gender,
    @required this.email,
    @required this.password,
    @required this.error,
  });

  /// This Function will trigger on saving the form
  ///
  /// The new value will be passed as the string parameter to the function
  final Function email;

  /// This Function will trigger on saving the form
  ///
  /// The new value will be passed as the string parameter to the function
  final Function password;

  /// This Function will trigger each time the value of name field changes
  ///
  /// The new value will be passed as the string parameter to the function
  final Function name;

  /// This Function will trigger each time the value of dob field changes
  ///
  /// The new value will be passed as the string parameter to the function
  final Function dob;

  /// This Function will trigger each time the value of gender field changes
  ///
  /// The new value will be passed as the string parameter to the function
  final Function gender;

  /// The `error message` you get after some operation can be passed to this function
  final Function error;

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  String dd, mm, yy, error, gender, password;

  List<String> days = [];
  List<String> months = [];
  List<String> years = [];

  TextEditingController textEditingController = TextEditingController();

  void _handleGenderFormField(String value) {
    setState(() {
      gender = value;
      textEditingController.value = TextEditingValue(text: gender == 'M' ? 'Male' : 'Female');
      textEditingController.text = gender == 'M' ? 'Male' : 'Female';
    });
    widget.gender(value);
  }

  List<bool> secureText = [true, true], focusPasswordField = [false, false];

  void toggleSecureText(int index) => setState(() => secureText[index] = !secureText[index]);

  void toggleFocusPasswordField(bool value, int index) => setState(() {
    if (value == false) {
      secureText[index] = true;
    }
    focusPasswordField[index] = value;
  });

  String _confirmPassword(String value) {
    if (value != password) {
      return 'Passwords don\'t match';
    } else {
      return null;
    }
  }

  String verifyAge() {
    if (this.dd == null && this.mm == null && this.yy == null) {
      setState(() => error = 'This is a required field');
      widget.error(true);
      return null;
    } else if (this.dd == null || this.mm == null || this.yy == null) {
      setState(() => error = 'Invalid date of birth');
      widget.error(true);
      return null;
    }

    int dd = int.parse(this.dd);
    int mm = int.parse(this.mm);

    if ((mm <= 7 && mm % 2 == 0 && dd == 31) ||
        (mm >= 8 && mm % 2 != 0 && dd == 31) ||
        (mm == 2 && dd > 29)) {
      setState(() => error = 'Invalid Date of Birth');
      widget.error(true);
    } else {
      setState(() => error = null);
      widget.error(false);
    }
    return null;
  }

  String getDOB() {
    return '$dd-$mm-$yy';
  }

  @override
  void initState() {
    super.initState();
    DateTime today = DateTime.now();
    for (int i = 1; i <= 31; ++i) days.add(i.toString());
    for (int i = 1; i <= 12; ++i) months.add(i.toString());
    for (int i = today.year - 10, j = 100; j > 0; --i, j--) years.add(i.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 48.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Name',
          ),
          buildCounter: (BuildContext context, { int currentLength, int maxLength, bool isFocused }) => null,
          maxLength: 20,
          onSaved: widget.name,
          validator: validateName,
        ),
        SizedBox(
          height: 15.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: DropdownButtonFormField(
                hint: Text(
                  'Day',
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: Colors.grey),
                ),
                items: days.map((day) => DropdownMenuItem(
                  child: Text('$day'),
                  value: day,
                )).toList(),
                onChanged: (value) => setState(() => dd = value),
                onSaved: (_) => widget.dob(getDOB()),
                value: dd,
                validator: (_) => verifyAge(),
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: DropdownButtonFormField(
                hint: Text(
                  'Mon',
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: Colors.grey),
                ),
                items: months.map((month) => DropdownMenuItem(
                  child: Text('$month'),
                  value: month,
                )).toList(),
                onChanged: (value) => setState(() => mm = value),
                value: mm,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: DropdownButtonFormField(
                hint: Text(
                  'Year',
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: Colors.grey),
                ),
                items: years.map((year) => DropdownMenuItem(
                  child: Text('$year'),
                  value: year,
                )).toList(),
                onChanged: (value) => setState(() => yy = value),
                value: yy,
              ),
            ),
          ],
        ),
        Visibility(
          visible: error != '' && error != null,
          child: Column(
            children: [
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    '$error',
                    style: kErrorMessageTextStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
          replacement: SizedBox(
            height: 15.0,
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: 'Gender',
                ),
                readOnly: true,
                validator: requiredFormField,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Radio(
                    value: 'M',
                    groupValue: gender,
                    onChanged: _handleGenderFormField,
                  ),
                  Text(
                    'M',
                    style: kDefaultTextStyle.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Radio(
                    value: 'F',
                    groupValue: gender,
                    onChanged: _handleGenderFormField,
                  ),
                  Text(
                    'F',
                    style: kDefaultTextStyle.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Email',
          ),
          keyboardType: TextInputType.emailAddress,
          onSaved: widget.email,
          validator: validateEmail,
        ),
        SizedBox(
          height: 15.0,
        ),
        FocusScope(
          onFocusChange: (focus) => toggleFocusPasswordField(focus, 0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'New Password',
              suffixIcon: !focusPasswordField[0] ? null :  IconButton(
                color: kDefaultThemeColor,
                icon: Icon(
                  secureText[0] ?
                  FontAwesomeIcons.solidEye :
                  FontAwesomeIcons.solidEyeSlash,
                ),
                onPressed: () => toggleSecureText(0),
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => password = value,
            onSaved: widget.password,
            obscureText: secureText[0],
            validator: validatePassword,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        FocusScope(
          onFocusChange: (focus) => toggleFocusPasswordField(focus, 1),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              suffixIcon: !focusPasswordField[1] ? null :  IconButton(
                color: kDefaultThemeColor,
                icon: Icon(
                  secureText[1] ?
                  FontAwesomeIcons.solidEye :
                  FontAwesomeIcons.solidEyeSlash,
                ),
                onPressed: () => toggleSecureText(1),
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
            obscureText: secureText[1],
            validator: _confirmPassword,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
