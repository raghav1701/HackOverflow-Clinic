import 'package:bug_busters/handlers/snackBar.dart';
import 'package:bug_busters/models/ear.dart';
import 'package:bug_busters/models/eye.dart';
import 'package:bug_busters/models/heart.dart';
import 'package:bug_busters/models/liver.dart';
import 'package:bug_busters/models/sugar.dart';
import 'package:bug_busters/screens/earTest/result.dart';
import 'package:bug_busters/screens/eyeTest/result.dart';
import 'package:bug_busters/screens/heart/result.dart';
import 'package:bug_busters/screens/liver/result.dart';
import 'package:bug_busters/screens/sugar/result.dart';
import 'package:bug_busters/services/firestore.dart';
import 'package:bug_busters/shared/functions.dart';
import 'package:bug_busters/widgets/common.dart';
import 'package:bug_busters/widgets/tiles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class TestsHistory extends StatefulWidget {

  @override
  _TestsHistoryState createState() => _TestsHistoryState();
}

class _TestsHistoryState extends State<TestsHistory> {

  BuildContext _scaffoldContext;
  String _uid;
  bool loading = false;

  void handleDownload(String docId, Map data) async {
    QuerySnapshot snapshot;
    Map doc;
    try {
      snapshot = await FirestoreService.kUsersCollectionReference.doc(_uid).collection('reports').doc(docId).collection('data').get();
      doc = snapshot.docs.first.data();
      if (doc == null) {
        throw 'error';
      }
    } catch (e) {
      handleSnackBar(context: _scaffoldContext, message: 'Error while parsing data');
      return;
    }

    int type = data['type'];

    if (type == 1) {
      HeartTestModel heartTestModel = HeartTestModel(
        name              : data['name'],
        age               : data['age'],
        gender            : data['gender'],
        chestPain         : doc['chestPain'],
        bloodPressure     : doc['bloodPressure'],
        cholestrol        : doc['cholestrol'],
        sugar             : doc['sugar'],
        electrocardiographic: doc['electrocardiographic'],
        maxHeart          : doc['maxHeart'],
        angina            : doc['angina'],
        stDepression      : doc['stDepression'],
        slope             : doc['slope'],
        bloodVessels      : doc['bloodVessels'],
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => HeartTestResults(heartTestData: heartTestModel, displayOnly: true)));
    } else if (type == 2) {
      LiverTestModel liverTestModel = LiverTestModel(
        name            : data['name'],
        age             : data['age'],
        gender          : data['gender'],
        totalBilirubin  : doc['tBilirubin'],
        directBilirubin : doc['dBilirubin'],
        phosphate       : doc['phosphate'],
        alamine         : doc['alamine'],
        aspartate       : doc['aspartate'],
        protein         : doc['protein'],
        albumin         : doc['albumin'],
        albuminByGlobulin:doc['globulin'],
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => LiverTestResults(liverTestData: liverTestModel, displayOnly: true)));
    } else if (type == 3) {
      SugarTestModel sugarTestModel = SugarTestModel(
        name            : data['name'],
        age             : data['age'],
        gender          : data['gender'],
        pregnancies     : doc['pregancies'],
        glucose         : doc['glucose'],
        bloodPressure   : doc['bloodPressure'],
        insulin         : doc['insulin'],
        height          : doc['height'],
        weight          : doc['weight'],
      );
      sugarTestModel.setParents(doc['parents']);
      print(sugarTestModel.parents);
      Navigator.push(context, MaterialPageRoute(builder: (context) => SugarTestResults(sugarTestData: sugarTestModel, displayOnly: true)));
    } else if (type == 4) {
      EyeTestModel eyeTestModel = EyeTestModel(
        name      : data['name'],
        age       : data['age'],
        gender    : data['gender'],
        visionAcuity  : doc['vision'],
        contrast      : doc['contrast'],
        colorBlindness: doc['blind'],
        astigmatism   : doc['astigmatism'],
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => TestResults(eyeTestData: eyeTestModel, displayOnly: true)));
    } else {
      EarTestModel earTestModel = EarTestModel(
        name  : data['name'],
        age   : data['age'],
        gender: data['gender'],
        score : doc['score'],
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => EarTestResults(earTestData: earTestModel, displayOnly: true)));
    }
  }

  String verifyType(int type) {
    if (type == 1) {
      return 'Heart';
    } else if (type == 2) {
      return 'Liver';
    } else if (type == 3) {
      return 'Sugar';
    } else if (type == 4) {
      return 'Eye';
    } else {
      return 'Ear';
    }
  }

  @override
  Widget build(BuildContext context) {
    _uid = Provider.of<FirestoreService>(context).uid;
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'History'
          ),
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: () => setState(() {})),
          ],
        ),

        body: StreamBuilder<QuerySnapshot>(
          stream: FirestoreService.kUsersCollectionReference.doc(_uid).collection('reports').orderBy('time', descending: true).get().asStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            }
            try {
              final List<DocumentSnapshot> reports = snapshot.data.docs;
              if (reports.isEmpty)
                throw 'No Previous Reports';
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListView.separated(
                  itemCount: reports.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                    indent: 1.0,
                    endIndent: 10.0,
                    height: 0.0,
                    thickness: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    _scaffoldContext = context;
                    Map data = reports[index].data();
                    String type = verifyType(data['type']);
                    return ReportHistoryTile(
                      action: () => handleDownload(reports[index].id, data),
                      title: data['name'] + ' (' + data['gender'] + ')',
                      subtitle: type + ' Test | ' + convertTimestampToDateTime(data['time']),
                    );
                  }
                ),
              );
            } catch (_) {
              return CenterHeaderText('No Checkup History');
            }
          },
        ),
      ),
    );
  }
}
