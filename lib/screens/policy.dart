import 'package:bug_busters/models/app.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppDetails.terms,
              textAlign: TextAlign.justify,
              style: kDefaultTextStyle,
            ),
            SubmitButton(
               title: '✅ Accepted',
              onPressed: () {}
            ),
          ],
        ),
      ),
    );
  }
}
