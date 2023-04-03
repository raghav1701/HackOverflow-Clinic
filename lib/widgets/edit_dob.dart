import 'package:flutter/material.dart';
import 'package:bug_busters/themes/decoration.dart';

class EditDateofBirthPane extends StatefulWidget {
  EditDateofBirthPane({
    @required this.save,
    @required this.title,
    this.value,
  });

  /// `Text` to be displayed in the header of this bottom sheet
  final String title;

  /// `Function` to be trigger when form data saved successfully without any errors
  final Function save;

  /// default value in the form field
  final String value;

  @override
  _EditDateofBirthPaneState createState() => _EditDateofBirthPaneState();
}

class _EditDateofBirthPaneState extends State<EditDateofBirthPane> {
  String dd, mm, yy, error;
  String finalDOB;

  List<String> days = [];
  List<String> months = [];
  List<String> years = [];

  bool saveButtonEnable = false;

  void buildAge() {
    widget.save(dd + '-' + mm + '-' + yy);
  }

  void verifyAge() {
    if (this.dd == null || this.mm == null || this.yy == null) {
      setState(() {
        error = 'Invalid Date';
        saveButtonEnable = false;
      });
      return;
    }

    finalDOB = this.dd + '-' + this.mm + '-' + this.yy;
    if (finalDOB == widget.value) {
      setState(() => saveButtonEnable = false);
      return;
    }

    int dd = int.parse(this.dd);
    int mm = int.parse(this.mm);

    if ((mm <=7 && mm%2==0 && dd == 31) || (mm>=8 && mm%2!=0 && dd == 31) || (mm == 2 && dd >29)) {
      setState(() {
        error = 'Invalid Date';
        saveButtonEnable = false;
      });
    } else {
      setState(() {
        error = null;
        saveButtonEnable = true;
      });
    }
  }

  void saveForm() {
    widget.save(finalDOB);
  }

  @override
  void initState() {
    super.initState();
    DateTime today = DateTime.now();

    for (int i=1 ; i<=31 ; ++i)
      days.add(i.toString());

    for (int i=1 ; i<=12 ; ++i)
      months.add(i.toString());

    for (int i=today.year, j=0  ; j<=100 ; --i, j++)
      years.add(i.toString());

    dd = widget.value.substring(0, widget.value.indexOf('-'));
    mm = widget.value.substring(widget.value.indexOf('-')+1, widget.value.lastIndexOf('-'));
    yy = widget.value.substring(widget.value.lastIndexOf('-')+1, widget.value.length);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  hint: Text('Day'),
                  items: days.map((day) => DropdownMenuItem(
                    child: Text('$day'),
                    value: day,
                  )).toList(),
                  onChanged: (value) {
                    setState(() => dd = value);
                    verifyAge();
                  },
                  value: dd,
                ),
                SizedBox(
                  width: 8.0,
                ),
                DropdownButton(
                  hint: Text('Month'),
                  items: months.map((month) => DropdownMenuItem(
                    child: Text('$month'),
                    value: month,
                  )).toList(),
                  onChanged: (value) {
                    setState(() => mm = value);
                    verifyAge();
                  },
                  value: mm,
                ),
                SizedBox(
                  width: 8.0,
                ),
                DropdownButton(
                  hint: Text('Year'),
                  items: years.map((year) => DropdownMenuItem(
                    child: Text('$year'),
                    value: year,
                  )).toList(),
                  onChanged: (value) {
                    setState(() => yy = value);
                    verifyAge();
                  },
                  value: yy,
                ),
              ],
            ),
            SizedBox(
              height: 14.0,
            ),
            Visibility(
              visible: error != '' && error != null,
              child: Center(
                child: Text(
                  '$error',
                  style: kErrorMessageTextStyle,
                ),
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
                  onPressed: saveButtonEnable ? saveForm : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
