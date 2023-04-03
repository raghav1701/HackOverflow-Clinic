import 'package:bug_busters/screens/authenticate/register_form.dart';
import 'package:bug_busters/services/authentication.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isLoading = false, _isError = false;

  BuildContext _scaffoldContext;

  String name, dob, gender, email, password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleSwitchingSigninAndRegister() {
    Navigator.pop(context);
  }

  void _handleRegisterRequest() {
    if (!_formKey.currentState.validate()) return;
    if (_isError) return;

    _formKey.currentState.save();

    AuthenticationService(
      email: email,
      password: password,
      waiting: (bool x) => setState(() => _isLoading = x),
    ).registerNewUserWithEmailAndPassword(_scaffoldContext, name, dob, gender);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        backgroundColor: kDefaultThemeColor,
        body: SafeArea(
          child: Builder(
            builder: (context) {
              _scaffoldContext = context;
              return _buildMobilePhoneBasedUI(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMobilePhoneBasedUI(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Register for Healthsy',
              style: kDefaultAppHeaderTextStyle,
            ),
            Form(
              key: _formKey,
              child: RegistrationForm(
                name: (value) => name = value,
                dob: (value) => dob = value,
                gender: (value) => gender = value,
                email: (value) => email = value,
                password: (value) => password = value,
                error: (value) => _isError = value,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubmitButton(
                  title: 'Register',
                  onPressed: _handleRegisterRequest,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: kDefaultTextStyle,
                ),
                GestureDetector(
                  child: Text(
                    'SignIn Now',
                    style: kDefaultTextStyle.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: _handleSwitchingSigninAndRegister,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
