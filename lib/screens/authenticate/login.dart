import 'package:bug_busters/handlers/dialog.dart';
import 'package:bug_busters/models/app.dart';
import 'package:bug_busters/screens/authenticate/login_form.dart';
import 'package:bug_busters/services/authentication.dart';
import 'package:bug_busters/shared/constants.dart';
import 'package:bug_busters/shared/routes.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  BuildContext _scaffoldContext;

  String email, password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleSwitchingSigninAndRegister() {
    handleAlertDialog(
      context: context,
      textContent: AppDetails.terms,
      title: 'Terms and Conditions',
      actionTitle: 'Accept',
      cancelTitle: 'Decline',
      action: () {
        Navigator.pop(context);
        setState(() {
          _formKey.currentState.reset();
        });
        Navigator.pushNamed(context, register);
      },
    );
  }

  void _handleSignInRequest() {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    AuthenticationService(
      email: email,
      password: password,
      waiting: (bool x) => setState(() => _isLoading = x),
    ).signInUserWithEmailAndPassword(_scaffoldContext);
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
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome To Healthsy',
            style: kDefaultAppHeaderTextStyle,
            textAlign: TextAlign.center,
          ),
          Flexible(
            child: SizedBox(
              height: 28.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(kSplashLogo),
                radius: 60.0,
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: LoginForm(
              email: (value) => email = value,
              password: (value) => password = value,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SubmitButton(
                title: 'Sign In',
                onPressed: _handleSignInRequest,
              ),
            ],
          ),
          Flexible(
            child: SizedBox(
              height: 48.0,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(
                'Don\'t have an account? ',
                style: kDefaultTextStyle,
              ),
              GestureDetector(
                child: Text(
                  'Register Now',
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
    );
  }
}
