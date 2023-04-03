import 'package:bug_busters/handlers/dialog.dart';
import 'package:bug_busters/handlers/snackBar.dart';
import 'package:bug_busters/models/eye.dart';
import 'package:bug_busters/screens/eyeTest/astigmatism_color_blind.dart';
import 'package:bug_busters/screens/eyeTest/questions.dart';
import 'package:bug_busters/screens/eyeTest/result.dart';
import 'package:bug_busters/screens/eyeTest/vision_contrast.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:bug_busters/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EyeTest extends StatefulWidget {
  @override
  _EyeTestState createState() => _EyeTestState();
}

class _EyeTestState extends State<EyeTest> {
  int _questionIndex = 0;
  int _testScreenIndex = 0;
  bool _isZeroQuestion = true;
  bool _isLastQuestion = false;

  bool _isFABEnable = true;
  BuildContext _scaffoldContext;

  EyeTestModel _score;

  bool _previousQuestionAnswerStatus = false;
  bool _isLoading = false;
  int _snackBarDuration = 500;

  final List<String> _titles = [
    'Vision Acuity Test',
    'Contrast Test',
    'Color Blindness Test',
    'Astigmatism Test',
  ];

  final List<String> _snackBarMessages = [
    'Yippee correct answer',
    'Yippee one more correct answer',
    'Oops! incorrect answer',
    'Oops! one more incorrect answer',
    'Nice',
    'Need checkup',
    'Suffering from Astigmatism',
    'Danger',
  ];

  void showSnackBar(bool correctAnswer) {
    int index = correctAnswer ? (_previousQuestionAnswerStatus ? 1 : 0) : (_previousQuestionAnswerStatus ? 2 : 3);
    _previousQuestionAnswerStatus = correctAnswer;
    handleSnackBar(
      context: _scaffoldContext,
      message: _snackBarMessages[index],
      milliseconds: _snackBarDuration,
    );
  }

  void handleIsLastQuestion() {
    if (_testScreenIndex == _titles.length - 1 && _questionIndex == astigmatismQuestionAnswer.length) {
      setState(() => _isLastQuestion = true);
    }
  }

  void handleFABGetStarted() {
    setState(() {
      _questionIndex++;
      _isZeroQuestion = false;
      _isFABEnable = false;
    });
    handleIsLastQuestion();
  }

  void handleFABNextQuestion() async {
    if (_testScreenIndex < _titles.length - 1 && (_questionIndex == visionAcuityQuestionAnswer.length || _questionIndex == contrastTestQuestionAnswer.length || _questionIndex == colorBlindTestQuestionAnswer.length)) {
      setState(() {
        _questionIndex = 0;
        _testScreenIndex++;
        _isZeroQuestion = true;
      });
    } else if (_isLastQuestion) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TestResults(eyeTestData: _score)));
    } else {
      setState(() {
        _questionIndex++;
        _isFABEnable = false;
      });
      handleIsLastQuestion();
    }
  }

  void handleAcuityForward(String value) {
    if (_isFABEnable == true)
      return;
    if (value == visionAcuityQuestionAnswer[_questionIndex - 1].solution) {
      _score.scoreVisionAcuity(visionAcuityQuestionAnswer[_questionIndex - 1].points);
      showSnackBar(true);
    } else {
      showSnackBar(false);
    }
    setState(() => _isFABEnable = true);
  }

  void handleContrastForward(String value) {
    if (_isFABEnable == true)
      return;
    if (value == contrastTestQuestionAnswer[_questionIndex - 1].solution) {
      _score.scoreContrast(
          contrastTestQuestionAnswer[_questionIndex - 1].points);
      showSnackBar(true);
    } else {
      showSnackBar(false);
    }
    setState(() => _isFABEnable = true);
  }

  void handleColorBlindnessForward(String value) {
    if (_isFABEnable == true)
      return;
    if (value == colorBlindTestQuestionAnswer[_questionIndex - 1].solution) {
      _score.scoreColorBlindness(colorBlindTestQuestionAnswer[_questionIndex - 1].points);
      showSnackBar(true);
    } else if (_questionIndex == colorBlindTestQuestionAnswer.length) {
      handleSnackBar(
        context: _scaffoldContext,
        message: 'A correct eye will see no number in this image',
        milliseconds: 2000,
      );
    } else {
      showSnackBar(false);
    }
    setState(() => _isFABEnable = true);
  }

  void handleAstigmatismForward(String value) {
    if (_isFABEnable == true)
      return;
    int index = astigmatismQuestionAnswer[_questionIndex - 1].options.indexOf(value);
    _score.scoreAstigmatism(astigmatismQuestionAnswer[_questionIndex - 1].points[index]);
    handleSnackBar(context: _scaffoldContext, message: _snackBarMessages[index+4], milliseconds: 2000);
    setState(() => _isFABEnable = true);
  }

  Widget handleRenderTestScreen(BuildContext context) {
    if (_isZeroQuestion) {
      return CenterHeaderText('Part ${_testScreenIndex+1}:\n${_titles[_testScreenIndex]}');
    } else if (_testScreenIndex == 0) {
      return VisionAndContrastTest(currentQuestion: _questionIndex, action: handleAcuityForward);
    } else if (_testScreenIndex == 1) {
      return VisionAndContrastTest(currentQuestion: _questionIndex, action: handleContrastForward, isVisionTest: false);
    } else if (_testScreenIndex == 2) {
      return ColorBlindnessAndAstigmatismTest(currentQuestion: _questionIndex, action: handleColorBlindnessForward);
    } else {
      return ColorBlindnessAndAstigmatismTest(currentQuestion: _questionIndex, action: handleAstigmatismForward, isColorBlindTest: false);
    }
  }

  @override
  void initState() {
    super.initState();
    _score = EyeTestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titles[_testScreenIndex]),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (_testScreenIndex == 0 && _isZeroQuestion) {
                Navigator.pop(context);
              } else {
                handleAlertDialog(
                  context: context,
                  textContent: 'Are you sure to leave the test in between?',
                  actionTitle: 'Leave',
                  action: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                );
              }
            },
          ),
        ),

        body: Builder(
          builder: (context) {
            _scaffoldContext = context;
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                child: handleRenderTestScreen(context),
              ),
            );
          },
        ),

        floatingActionButton: SubmitButton(
          enable: _isFABEnable,
          onPressed: _isZeroQuestion ? handleFABGetStarted : handleFABNextQuestion,
          title: !_isFABEnable ? 'Waiting' : _isZeroQuestion ? 'Start Test' : _isLastQuestion ? 'Submit' : 'Next',
        ),
      ),
    );
  }
}
