import 'package:bug_busters/screens/earTest/questions.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:flutter/material.dart';

class TrueFalseQuestion extends StatelessWidget {
  TrueFalseQuestion({
    @required this.action,
    @required this.currentQuestion,
  });

  final Function action;
  final int currentQuestion;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              '${earQuestions[currentQuestion]}',
              style: kDefaultTextStyleLarge,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceButton(
              action: action,
              value: 'NO',
            ),
            SizedBox(
              width: 10.0,
            ),
            ChoiceButton(
              action: action,
              color: Colors.redAccent,
              value: 'YES',
            ),
          ],
        ),
      ],
    );
  }
}
