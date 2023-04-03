import 'package:bug_busters/screens/earTest/questions.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:flutter/material.dart';

class SoundTrueFalseQuestion extends StatelessWidget {
  const SoundTrueFalseQuestion({
    @required this.index,
    @required this.action,
    @required this.play,
  });

  final int index;
  final Function action;
  final Function play;

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
              '${soundQuestionTrueFalse[index]}',
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
            RaisedButton.icon(
              icon: Icon(Icons.play_arrow),
              label: Text('Play Sound'),
              onPressed: () => play('sound2_${index+1}'),
            ),
          ],
        ),
        SizedBox(
          height: 50.0,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            ChoiceButton(
              action: action,
              color: Colors.redAccent,
              value: 'NO',
            ),
            SizedBox(
              width: 10.0,
            ),
            ChoiceButton(
              action: action,
              value: 'YES',
            ),
          ],
        ),
      ],
    );
  }
}
