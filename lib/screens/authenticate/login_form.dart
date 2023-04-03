import 'package:bug_busters/themes/decoration.dart';
import 'package:flutter/material.dart';
import 'package:bug_busters/shared/validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatefulWidget {
  LoginForm({@required this.email, @required this.password});

  /// This Function will trigger on saving the form
  ///
  /// The new value will be passed as the string parameter to the function
  final Function email;

  /// This Function will trigger on saving the form
  ///
  /// The new value will be passed as the string parameter to the function
  final Function password;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  bool secureText = true, focusPasswordField = false;

  void toggleSecureText() => setState(() => secureText = !secureText);
  void toggleFocusPasswordField(bool value) => setState(() {
    if (value == false) {
      secureText = true;
    }
    focusPasswordField = value;
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 48.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter your email',
          ),
          keyboardType: TextInputType.emailAddress,
          onSaved: widget.email,
          validator: validateEmail,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 15.0,
        ),
        FocusScope(
          onFocusChange: toggleFocusPasswordField,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your Password',
              suffixIcon: !focusPasswordField ? null :  IconButton(
                color: kDefaultThemeColor,
                icon: Icon(
                  secureText ?
                  FontAwesomeIcons.solidEye :
                  FontAwesomeIcons.solidEyeSlash,
                ),
                onPressed: toggleSecureText,
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
            onSaved: widget.password,
            obscureText: secureText,
            validator: validatePassword,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
