import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bug_busters/models/message.dart';
import 'package:bug_busters/services/firestore.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:bug_busters/models/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TestResultsBody extends StatefulWidget {
  const TestResultsBody({
    @required this.body,
    @required this.displayOnly,
    @required this.object,
    @required this.url,
    @required this.type,
  });

  final String body;
  final bool displayOnly;
  final dynamic object;
  final int type;
  final String url;

  @override
  _TestResultsBodyState createState() => _TestResultsBodyState();
}

class _TestResultsBodyState extends State<TestResultsBody> {
  bool _isLoading = true;
  bool _isError = false;
  bool _publishError = false;
  bool showResult = false;
  bool _isFirebaseError = false;
  String message;
  http.Response response;

  void saveDataOnFirestoreServer() async {
    setState(() {
      _isLoading = true;
      _isError = _isFirebaseError = false;
      message = 'Saving data on firestore...';
    });

    ResultMessage result = await Provider.of<FirestoreService>(context, listen: false).saveResultDataOnFirestoreServer(widget.type, widget.object);

    if (result.code != '1') {
      setState(() {
        _isLoading = false;
        _isError = _isFirebaseError = true;
        message = 'Failed to save data on firestore';
      });
    } else {
      handleData();
    }
  }

  void handleData() async {
    setState(() {
      _isError = false;
      _isLoading = true;
      message = 'Generating your report...';
    });

    try {
      response = await http.post(
        widget.url,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: widget.body,
      ).timeout(Duration(seconds: 10));
      if (response.statusCode == 400) {
        throw 'Client error 400';
      } else if (response.statusCode == 500) {
        throw 'Internal server error: 500';
      } else if (response.statusCode == 200) {
        setState(() => message = 'Your results are here');
        if (!widget.displayOnly) {
          publishDataOnStreamrNetwork();
        } else {
          setState(() => _isLoading = false);
        }
      }
    } on TimeoutException catch (e) {
      setError(e.message ?? 'Connection Timeout');
      setState(() => _isLoading = false);
    } on PlatformException catch (e) {
      setError(e.message ?? 'Unknown Platform Error');
      setState(() => _isLoading = false);
    } on SocketException catch (e) {
      setError(e.message ?? 'Unknown socket error');
      setState(() => _isLoading = false);
    } catch (e) {
      setError(e.toString());
      setState(() => _isLoading = false);
    }
  }

  void publishDataOnStreamrNetwork() async {
    setState(() {
      _publishError = false;
      _isLoading = true;
      message = 'Publishing data to streamr network...';
    });

    String route = widget.type == 1 ? 'heart' : widget.type == 2 ? 'liver' : 'sugar';

    Map<String, dynamic> data = json.decode(widget.body);
    data.addAll({
      'result' : getResultFromResponse(),
    });
    String body = json.encode(data);

    try {
       http.Response response = await http.post(
        RestAPI.streamrNetwork + route,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: body,
      ).timeout(Duration(seconds: 10));
      if (response.statusCode == 400) {
        throw 'Client error 400';
      } else if (response.statusCode == 500) {
        throw 'Internal server error: 500';
      } else if (response.statusCode == 200) {
        setState(() => message = 'Your results are here');
      }
    } on TimeoutException catch (e) {
      setPublishError(e.message ?? 'Connection Timeout');
    } on PlatformException catch (e) {
      setPublishError(e.message ?? 'Unknown Platform Error');
    } on SocketException catch (e) {
      setPublishError(e.message ?? 'Unknown socket error');
    } catch (e) {
      setPublishError(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String getResultFromResponse() {
    int index = response.body.indexOf('S');
    if (index > 4 || index == -1) {
      return 'Good Health';
    }
    return 'Not Good';
  }

  void setError(String text) {
    setState(() {
      message = text;
      _isError = true;
    });
  }

  void setPublishError(String text) {
    setState(() {
      message = text;
      _publishError = true;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.displayOnly) {
      handleData();
    } else {
      saveDataOnFirestoreServer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              visible: _isError || _publishError,
              child: Center(
                child: Text(
                  '🤯',
                  style: kDefaultTextStyle.copyWith(
                    fontSize: 64.0,
                  ),
                ),
              ),
              replacement: Center(
                child: Text(
                  response == null ? '' : response.body == null ? '' : response.body,
                  style: kDefaultTextStyle.copyWith(
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SubmitButton(
                enable: !_isLoading,
                title: _isLoading ? 'Please Wait' :
                  (_isError || _publishError) ? 'Retry' :
                  'Back to Home',
                onPressed: _isLoading ? () {} :
                  _isFirebaseError ? saveDataOnFirestoreServer :
                  _isError ? handleData :
                  _publishError ? publishDataOnStreamrNetwork :
                  () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
