String validateEmail(String email) {
  if (email.isEmpty)
    return 'This is a required field';

  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(p);

  return regExp.hasMatch(email) ? null : 'Invalid Email';
}

String validateName(String name) {
  if (name.isEmpty)
    return 'This is a required field';

  if (name.contains(RegExp(r'[0-9]')))
    return 'Numbers not allowed';

  return null;
}

String validatePassword(String password) {
  if (password.isEmpty)
    return 'This is a required field';
  if (password.length < 8)
    return 'Password length should be greater or equal to 8';
  if (!password.contains(RegExp(r'[0-9]')))
    return 'Password should contain atleast one number';
  return null;
}

String requiredFormField(String text) {
  if (text.isEmpty)
    return 'This is a required field';
  return null;
}

String validateStringIsDouble(String text) {
  if (text == null)
    return 'This is a required field';
  if (text.isEmpty)
    return 'This is a required field';
  if (double.tryParse(text) == null)
    return 'Invalid value';
  return null;
}
