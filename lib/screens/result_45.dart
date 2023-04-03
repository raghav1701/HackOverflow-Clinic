import 'package:bug_busters/models/ear.dart';
import 'package:bug_busters/models/eye.dart';
import 'package:bug_busters/models/message.dart';
import 'package:bug_busters/services/firestore.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class TestResultsBody extends StatefulWidget {
  const TestResultsBody({
    @required this.object,
    @required this.type,
    @required this.displayOnly,
  });

  final dynamic object;
  final int type;
  final bool displayOnly;

  @override
  _TestResultsBodyState createState() => _TestResultsBodyState();
}

class _TestResultsBodyState extends State<TestResultsBody> {
  bool _isLoading = true;
  bool _isError = false;
  String message;
  Widget result;

  void saveDataOnFirestoreServer() async {
    setState(() {
      _isLoading = true;
      _isError = false;
      message = 'Saving data on firestore...';
    });

    ResultMessage result = await Provider.of<FirestoreService>(context, listen: false).saveResultDataOnFirestoreServer(widget.type, widget.object);

    if (result.code != '1') {
      setState(() {
        _isLoading = false;
        _isError = true;
        message = 'Failed to save data on firestore';
      });
    } else {
      handleDisplayReport();
    }
  }

  EyeTestResults createEyeTestReport(EyeTestModel eyeTestModel) {
    EyeTestResults eyeTestResults = EyeTestResults();
    if (eyeTestModel.visionAcuity > 16) {
      eyeTestResults.visionAcuity = 'Your Eyes are good';
    } else if (eyeTestModel.visionAcuity > 12) {
      eyeTestResults.visionAcuity = 'Your may need to consult a doctor';
    } else{
      eyeTestResults.visionAcuity = 'Your eyes are in critical stage, consult a doctor now';
    }

    if (eyeTestModel.contrast >= 9) {
      eyeTestResults.contrast = 'Your Eyes are good';
    } else if (eyeTestModel.contrast > 6) {
      eyeTestResults.contrast = 'Your may need to consult a doctor';
    } else{
      eyeTestResults.contrast = 'Your eyes are in critical stage, consult a doctor now';
    }

    if (eyeTestModel.colorBlindness >= 9) {
      eyeTestResults.colorBlindness = 'Your Eyes are good';
    } else if (eyeTestModel.colorBlindness > 6) {
      eyeTestResults.colorBlindness = 'Your may need to consult a doctor';
    } else{
      eyeTestResults.colorBlindness = 'Your eyes are in critical stage, consult a doctor now';
    }

    if (eyeTestModel.astigmatism == 5) {
      eyeTestResults.astigmatism = 'Your Eyes are good';
    } else if (eyeTestModel.astigmatism >= 3) {
      eyeTestResults.astigmatism = 'Your may need to consult a doctor';
    } else{
      eyeTestResults.astigmatism = 'Your eyes are in critical stage, consult a doctor now';
    }

    return eyeTestResults;
  }

  String createEarTestReport(EarTestModel earTestModel) {
    if (earTestModel.score > 6) {
      return 'Your Ears are good';
    } else if (earTestModel.score > 4) {
      return 'Your may need to consult a doctor';
    } else {
      return 'Your ears are in critical stage, consult a doctor now';
    }
  }

  void handleDisplayReport() {
    setState(() {
      message = 'Your results are here';
      _isLoading = false;
    });

    if (widget.type == 4) {
      EyeTestResults eyeTestResults = createEyeTestReport(widget.object);

      Map<String, String> data = {
        'Vision'          : eyeTestResults.visionAcuity,
        'Contrast'        : eyeTestResults.contrast,
        'Color Blindness' : eyeTestResults.colorBlindness,
        'Astigamtism'     : eyeTestResults.astigmatism,
      };

      setState(() {
        this.result = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: kDefaultThemeColor, width: 2.0)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${entry.key} - ',
                          style: kDefaultTextStyle.copyWith(
                            fontFamily: 'Aclonica',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${entry.value}',
                          style: kDefaultTextStyleLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList()
        );
      });
    } else {
      this.result = Text(
        '${createEarTestReport(widget.object)}',
        style: kDefaultTextStyle.copyWith(
          fontSize: 24.0,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    this.result = Text('');
    if (widget.displayOnly) {
      handleDisplayReport();
    } else {
      saveDataOnFirestoreServer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: _isLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Report Submitted for further analysis',
                  style: kDefaultHeaderTextStyle,
                ),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  '$message',
                  style: kDefaultTextStyleLarge,
                ),
              ],
            ),
            Visibility(
              visible: _isLoading,
              child: SpinKitChasingDots(
                color: kDefaultThemeColor,
              ),
              replacement: Visibility(
                visible: _isError,
                child: Center(
                  child: Text(
                    '🤯',
                    style: kDefaultTextStyle.copyWith(
                      fontSize: 64.0,
                    ),
                  ),
                ),
                replacement: result,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubmitButton(
                  enable: !_isLoading,
                  title: _isLoading ? 'Please Wait' :
                    _isError && !_isLoading ? 'Retry' :
                    'Back to Home',
                  onPressed: _isError && !_isLoading ? saveDataOnFirestoreServer :() => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
