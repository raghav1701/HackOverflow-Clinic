import 'package:audioplayers/audio_cache.dart';
import 'package:bug_busters/handlers/dialog.dart';
import 'package:bug_busters/handlers/snackBar.dart';
import 'package:bug_busters/models/ear.dart';
import 'package:bug_busters/screens/earTest/result.dart';
import 'package:bug_busters/screens/earTest/sound_mcq.dart';
import 'package:bug_busters/screens/earTest/sound_true_false.dart';
import 'package:bug_busters/screens/earTest/true_false.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:bug_busters/screens/earTest/questions.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:bug_busters/widgets/common.dart';

class EarTest extends StatefulWidget {
  @override
  _EarTestState createState() => _EarTestState();
}

class _EarTestState extends State<EarTest> {
  final player = AudioCache();

  int _currentQuestion = -1;
  bool _isFABEnable = true;
  bool _isZeroQuestion = true;
  bool _isLastQuestion = false;

  EarTestModel _score;
  BuildContext _scaffoldContext;

  int _snackBarDuration = 500;
  bool _isLoading = false;

  int currentStreak = 1;

  final List<String> _snackBarMessages = [
    'Oops!',
    'Oh No!',
    'Good',
    'Nice',
    'Awesome',
  ];

  void showSnackBar(bool correctAnswer) {
    if (!correctAnswer) {
      if (currentStreak == 0) {
        currentStreak = 1;
      } else if (currentStreak != 1) {
        currentStreak = 0;
      }
    } else if (currentStreak < 2) {
      currentStreak = 2;
    } else if (currentStreak < 4) {
      currentStreak++;
    }

    handleSnackBar(
      context: _scaffoldContext,
      message: _snackBarMessages[currentStreak],
      milliseconds: _snackBarDuration,
    );
  }

  void handleFABGetStarted() {
    setState(() {
      _currentQuestion++;
      _isZeroQuestion = false;
      _isFABEnable = false;
    });
  }

  void handleFABNextQuestion() async {
    if (_currentQuestion == 8) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EarTestResults(earTestData: _score)));
    } else {
      setState(() {
        _currentQuestion++;
        _isFABEnable = false;
      });
    }
  }

  void handleYesNoQuestion(String value) {
    if (_isFABEnable == true) return;
    if (value == 'NO') {
      _score.scoreEars();
      showSnackBar(true);
    } else {
      showSnackBar(false);
    }
    setState(() => _isFABEnable = true);
  }

  void handleSoundMCQs(String value, int index) {
    if (_isFABEnable == true)
      return;
    else if (value == soundMCQAnswer[index].solution) {
      _score.scoreEars();
      showSnackBar(true);
    } else {
      showSnackBar(false);
    }
    setState(() => _isFABEnable = true);
  }

  void handleSoundQuestionYesNo(String value) {
    if (_isFABEnable == true)
      return;
    else if (value == 'YES') {
      _score.scoreEars(points: 2);
      showSnackBar(true);
    } else {
      showSnackBar(true);
    }
    setState(() {
      _isFABEnable = true;
      _isLastQuestion = true;
    });
  }

  void playSound(String sound) {
    if (!_isFABEnable)
      player.play('sounds/$sound.mp3');
  }

  Widget handleRenderTestScreen(BuildContext context) {
    if (_currentQuestion == -1) {
      return CenterHeaderText('Tap the start button to start the test.');
    } else if (_currentQuestion < earQuestions.length) {
      return TrueFalseQuestion(currentQuestion: _currentQuestion, action: handleYesNoQuestion);
    } else if (_currentQuestion == 7) {
      return SoundQuestionWithMultipleChoice(index: 0, play: playSound, action: handleSoundMCQs);
    } else {
      return SoundTrueFalseQuestion(index: 0, play: playSound, action: handleSoundQuestionYesNo);
    }
  }

  @override
  void initState() {
    super.initState();
    _score = EarTestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ear Sensitivity Test'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (_isZeroQuestion) {
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
