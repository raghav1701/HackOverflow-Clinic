import 'package:bug_busters/models/question.dart';

final List<String> earQuestions = [
  'Do you sometimes find it challenging to have a conversation in quiet surroundings?',
  'Do you find it difficult to understand speech on TV and radio?',
  'Do you often have to ask people to repear themselves?',
  'Do you find it hard to have a conversation on the phone?',
  'Do you sometimes have difficulty understanding speech on the telephone or TV?',
  'Do you sometimes feel people are mumbling or not speaking clearly?',
  'Do you find it difficult to follow a conversation in a noisy restaurant or crowded room?',
];

final List<String> soundMCQ = [
  'How many times the sound repeats?',
];

final List<MCQ> soundMCQAnswer = [
  MCQ(
    options: ['3', '2', '4', 'None'],
    solution: '4',
  ),
];

final List<String> soundQuestionTrueFalse = [
  'Can you hear the sound?',
];
