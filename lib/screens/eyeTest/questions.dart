import 'package:bug_busters/models/question.dart';

final String visionAcuityQuestion = 'Choose corresponding arrow option indicating the direction of the open side of the \'E\'.';
final List<MCQTypeThree> visionAcuityQuestionAnswer = [
  MCQTypeThree(
    solution: 'L',
  ),
  MCQTypeThree(
    solution: 'R',
  ),
  MCQTypeThree(
    solution: 'T',
  ),
  MCQTypeThree(
    solution: 'B',
  ),
  MCQTypeThree(
    solution: 'L',
  ),
  MCQTypeThree(
    solution: 'B',
    points: 2,
  ),
  MCQTypeThree(
    solution: 'T',
    points: 2,
  ),

  MCQTypeThree(
    solution: 'B',
    points: 2,
  ),
  MCQTypeThree(
    solution: 'T',
    points: 2,
  ),
  MCQTypeThree(
    solution: 'R',
    points: 3,
  ),
  MCQTypeThree(
    solution: 'T',
    points: 3,
  ),
  MCQTypeThree(
    solution: 'L',
    points: 3,
  ),
];

final String contrastTestQuestion = 'Choose corresponding arrow option indicating the direction of the open side of the \'C\'.';
final List<MCQTypeThree> contrastTestQuestionAnswer = [
  MCQTypeThree(
    solution: 'L',
  ),
  MCQTypeThree(
    solution: 'T',
  ),
  MCQTypeThree(
    solution: 'B',
  ),
  MCQTypeThree(
    solution: 'T',
  ),
  MCQTypeThree(
    solution: 'B',
  ),
  MCQTypeThree(
    solution: 'R',
  ),
  MCQTypeThree(
    solution: 'L',
  ),
  MCQTypeThree(
    solution: 'R',
  ),
  MCQTypeThree(
    solution: 'L',
  ),
  MCQTypeThree(
    solution: 'T',
  ),
];

final String colorBlindTestQuestion = 'Choose appropriate option out of given 4 corresponding to the number shown in the image.';
final List<MCQ> colorBlindTestQuestionAnswer = [
  MCQ(
    options: ['13', '12', '19', 'None'],
    points: 1,
    solution: '12',
  ),
  MCQ(
    options: ['18', '68', '29', 'None'],
    points: 2,
    solution: '29',
  ),
  MCQ(
    options: ['15', '78', '19', 'None'],
    points: 2,
    solution: '15',
  ),
  MCQ(
    options: ['87', '69', '97', 'None'],
    points: 2,
    solution: '97',
  ),
  MCQ(
    options: ['76', '18', '16', 'None'],
    points: 2,
    solution: '16',
  ),
  MCQ(
    options: ['69','27', '13', 'None'],
    points: 3,
    solution: 'None',
  ),
];

final String astigmatismQuestion = 'How does the lines in the image looks like?';
final List<MCQWithMultipleAnswer> astigmatismQuestionAnswer = [
  MCQWithMultipleAnswer(
    options: ['Perfect', 'Blurry', 'Curved', 'Can\'t See'],
    points: [5, 3, 1, 0],
  ),
];
