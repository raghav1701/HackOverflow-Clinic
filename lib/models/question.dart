import 'package:flutter/foundation.dart';

class MCQ {
  List<String> options;
  int points;
  String solution;

  MCQ({
    @required this.options,
    this.points = 1,
    @required this.solution,
  });
}

class MCQWithMultipleAnswer {
  List<String> options;
  List<int> points;

  MCQWithMultipleAnswer({
    @required this.options,
    @required this.points,
  });
}

class MCQTypeThree {
  int points;
  String solution;

  MCQTypeThree({
    this.points = 1,
    @required this.solution,
  });
}

class TrueFalseQuestion {
  int points;
  bool answer;

  TrueFalseQuestion({
    @required this.answer,
    this.points = 1,
  });
}
