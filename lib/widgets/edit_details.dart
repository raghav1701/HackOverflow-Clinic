import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bug_busters/themes/decoration.dart';

class EditDetailsPane extends StatefulWidget {
  EditDetailsPane({
    @required this.save,
    @required this.title,
    this.autoFocus = true,
    this.hintText = '',
    this.maxLength,
    this.secureText = false,
    this.validator,
    this.value,
  });

  /// `Text` to be displayed in the header of this bottom sheet
  final String title;

  /// `Function` to be trigger when form data saved successfully without any errors
  final Function save;

  /// `autoFocus (=true)`. Do auto focus in the text field
  final bool autoFocus;

  /// `MaxLength` of the text field defaults to infinity
  final int maxLength;

  /// `Text` to be displayed inside text field as hint
  final String hintText;

  /// Set it to `true` in case you're using it as password field
  final bool secureText;

  /// Function to be triggered to validate form data
  final Function validator;

  /// default value in the form field
  final String value;

  @override
  _EditDetailsPaneState createState() => _EditDetailsPaneState();
}

class _EditDetailsPaneState extends State<EditDetailsPane> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController;
  bool saveButtonEnable = false;
  bool secureText = false;

  void saveForm() {
    if (!_formKey.currentState.validate() || !saveButtonEnable)
      return;
    else
      _formKey.currentState.save();
  }

  void onChange(value) {
    if (value.isEmpty || value == widget.value)
      setState(() => saveButtonEnable = false);
    else
      setState(() => saveButtonEnable = true);
  }

  void toggleSecureText() {
    setState(() => secureText = !secureText);
  }

  @override
  void initState() {
    super.initState();
    secureText = widget.secureText;
    textEditingController = TextEditingController(text: widget.value);
    if (widget.value != null) {
      textEditingController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: widget.value.length,
      );
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.title}',
              style: kDefaultTextStyleBold,
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 16.0,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                autofocus: widget.autoFocus,
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  suffixIcon: widget.secureText == true ? IconButton(
                    icon: Icon(
                      secureText ?
                      FontAwesomeIcons.solidEye :
                      FontAwesomeIcons.solidEyeSlash,
                    ),
                    color: kDefaultThemeColor,
                    onPressed: toggleSecureText,
                  ) :
                  null,
                ),
                obscureText: secureText,
                onChanged: onChange,
                onSaved: widget.save,
                maxLength: widget.maxLength,
                validator: widget.validator,
              ),
            ),
            ButtonBar(
              children: [
                FlatButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: kDefaultThemeColor,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: saveButtonEnable ? kDefaultThemeColor : Colors.grey,
                    ),
                  ),
                  onPressed: saveForm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
