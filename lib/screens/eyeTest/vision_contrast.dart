import 'package:bug_busters/screens/eyeTest/questions.dart';
import 'package:bug_busters/shared/constants.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:flutter/material.dart';

class VisionAndContrastTest extends StatelessWidget {
  VisionAndContrastTest({
    @required this.currentQuestion,
    @required this.action,
    this.isVisionTest = true,
  });

  final int currentQuestion;
  final bool isVisionTest;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isVisionTest ? '$visionAcuityQuestion' : '$contrastTestQuestion',
          style: kDefaultTextStyleLarge,
          textAlign: TextAlign.justify,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquaredIconButton(
                  action: action,
                  icon: Icons.arrow_upward,
                  value: 'T',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquaredIconButton(
                  action: action,
                  icon: Icons.arrow_back,
                  value: 'L',
                ),
                Padding(
                  padding: isVisionTest ? EdgeInsets.all(10.0) : EdgeInsets.all(40.0),
                  child: Image(
                    image: AssetImage(
                      (isVisionTest ? '$kVisionTestImages': '$kContrastTestImages') + '$currentQuestion.png',
                    ),
                    height: isVisionTest ? 100 : 40,
                    width: isVisionTest ? 100 : 40,
                  ),
                ),
                SquaredIconButton(
                  action: action,
                  icon: Icons.arrow_forward,
                  value: 'R',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquaredIconButton(
                  action: action,
                  icon: Icons.arrow_downward,
                  value: 'B',
                ),
              ],
            ),
          ],
        ),
        Container(
          width: double.infinity,
        ),
      ],
    );
  }
}
