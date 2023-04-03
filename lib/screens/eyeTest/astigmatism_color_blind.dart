import 'package:bug_busters/screens/eyeTest/questions.dart';
import 'package:bug_busters/shared/constants.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ColorBlindnessAndAstigmatismTest extends StatelessWidget {
  ColorBlindnessAndAstigmatismTest({
    @required this.currentQuestion,
    @required this.action,
    this.isColorBlindTest = true,
  });

  final int currentQuestion;
  final bool isColorBlindTest;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isColorBlindTest ? '$colorBlindTestQuestion' : '$astigmatismQuestion',
          style: kDefaultTextStyleLarge,
          textAlign: TextAlign.justify,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Image(
                      image: AssetImage(
                        (isColorBlindTest ? '$kColorBlindnessTestImages' : '$kAstigmatismTestImage') + '$currentQuestion.png',
                      ),
                      width: 300,
                    ),
                  ),
                ),
              ],
            ),
          ]..addAll(
            [0, 2].map((index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceButton(
                    action: action,
                    value: isColorBlindTest ? colorBlindTestQuestionAnswer[currentQuestion - 1].options[index]
                      : astigmatismQuestionAnswer[currentQuestion - 1].options[index],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  ChoiceButton(
                    action: action,
                    value: isColorBlindTest ? colorBlindTestQuestionAnswer[currentQuestion - 1].options[index + 1]
                      : astigmatismQuestionAnswer[currentQuestion - 1].options[index + 1],
                  ),
                ],
              );
            }),
          )
        ),
        Container(
          width: double.infinity,
        ),
      ],
    );
  }
}
