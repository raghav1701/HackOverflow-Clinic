import 'dart:async';
import 'dart:io';
import 'package:bug_busters/models/ear.dart';
import 'package:bug_busters/models/eye.dart';
import 'package:bug_busters/models/heart.dart';
import 'package:bug_busters/models/liver.dart';
import 'package:bug_busters/models/sugar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:bug_busters/models/message.dart';
import 'package:bug_busters/models/user.dart';

class FirestoreService extends ChangeNotifier {
  LocalUser _currentUser = LocalUser();

  /// Get read only curretly signed in user's uid.
  String get uid   => _currentUser.uid;

  /// Get read only curretly signed in user's name.
  String get name  => _currentUser.name;

  /// Get read only curretly signed in user's email.
  String get email => _currentUser.email;

  /// Get read only curretly signed in user's date of birth.
  String get dob   => _currentUser.dob;

  /// Get read only curretly signed in user's age.
  int get age      => _currentUser.age;

  /// Get read only curretly signed in user's gender.
  String get gender      => _currentUser.gender;

  FirebaseAuth _auth = FirebaseAuth.instance;

  /// set user data in provider cache
  void setUser(LocalUser user) => _currentUser.set(user);

  /// SingOut current user and clear local cached data also
  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
      _currentUser.clear();
    } catch (e) {
      print(e);
    }
  }

  /// `Collection Reference` to the users collection in the firestore database.
  static final CollectionReference kUsersCollectionReference = FirebaseFirestore.instance.collection('users');

  static Future<bool> documentExist(DocumentReference documentReference) async {
    bool exists = false;
    try {
      await documentReference.get().then((doc) {
        exists = doc.exists ? true : false;
      }).timeout(Duration(seconds: 4));
      return exists;
    } catch (e) {
      return false;
    }
  }

  Future<ResultMessage> createNewUserDatabase() async {
    try {
      await kUsersCollectionReference.doc(_currentUser.uid).set({
        'name': _currentUser.name,
        'dob': _currentUser.dob,
        'gender': _currentUser.gender,
      }).timeout(Duration(seconds: 4));
      return ResultMessage(code: '1', message: 'User Created Successfully');
    } on PlatformException catch (e) {
      return ResultMessage(code: '2', message: e.message ?? 'Unknown Platform Error');
    } on TimeoutException catch (_) {
      return ResultMessage(code: '3', message: 'Connection Timeout');
    } on SocketException catch (e) {
      return ResultMessage(code: '4', message: e.message ?? 'Unknown socket error');
    } catch (e) {
      return ResultMessage(code: '5', message: 'Unknown Error');
    }
  }

  Future<ResultMessage> saveResultDataOnFirestoreServer(int type, dynamic object) async {
    try {
      DocumentReference docRef = await kUsersCollectionReference.doc(_currentUser.uid).collection('reports').add({
        'name': object.name,
        'age' : object.age,
        'gender': object.gender,
        'time': Timestamp.now(),
        'type': type,
      });

      Map<String, dynamic> data;

      if (type == 1) {
        HeartTestModel heartTestModel = object;
        data = {
          'chestPain'       : heartTestModel.chestPain,
          'bloodPressure'   : heartTestModel.bloodPressure,
          'cholestrol'      : heartTestModel.cholestrol,
          'sugar'           : heartTestModel.sugar,
          'electrocardiographic': heartTestModel.electrocardiographic,
          'maxHeart'        : heartTestModel.maxHeart,
          'angina'          : heartTestModel.angina,
          'stDepression'    : heartTestModel.stDepression,
          'slope'           : heartTestModel.slope,
          'bloodVessels'    : heartTestModel.bloodVessels,
        };
      } else if (type == 2) {
        LiverTestModel liverTestModel = object;
        data = {
          'tBilirubin'  : liverTestModel.totalBilirubin,
          'dBilirubin'  : liverTestModel.directBilirubin,
          'phosphate'   : liverTestModel.phosphate,
          'alamine'     : liverTestModel.alamine,
          'aspartate'   : liverTestModel.aspartate,
          'protein'     : liverTestModel.protein,
          'albumin'     : liverTestModel.albumin,
          'globulin'    : liverTestModel.albuminByGlobulin,
        };
      } else if (type == 3) {
        SugarTestModel sugarTestModel = object;
        data = {
          'pregancies'  : sugarTestModel.pregnancies,
          'glucose'     : sugarTestModel.glucose,
          'bloodPressure': sugarTestModel.bloodPressure,
          'insulin'     : sugarTestModel.insulin,
          'height'      : sugarTestModel.height,
          'weight'      : sugarTestModel.weight,
          'parents'     : sugarTestModel.parents,
        };
      } else if (type == 4) {
        EyeTestModel eyeTestModel = object;
        data = {
          'vision': eyeTestModel.visionAcuity,
          'contrast' : eyeTestModel.contrast,
          'blind' : eyeTestModel.colorBlindness,
          'astigmatism': eyeTestModel.astigmatism,
        };
      } else {
        EarTestModel earTestModel = object;
        data = {
          'score': earTestModel.score,
        };
      }

      await kUsersCollectionReference.doc(_currentUser.uid).collection('reports').doc(docRef.id).collection('data').add(data);

      return ResultMessage(code: '1', message: 'User Created Successfully');
    } on PlatformException catch (e) {
      return ResultMessage(code: '2', message: e.message ?? 'Unknown Platform Error');
    } on TimeoutException catch (_) {
      return ResultMessage(code: '3', message: 'Connection Timeout');
    } on SocketException catch (e) {
      return ResultMessage(code: '4', message: e.message ?? 'Unknown socket error');
    } catch (e) {
      return ResultMessage(code: '5', message: 'Unknown Error');
    }
  }

  Future<ResultMessage> deleteCheckupReportFromFirestoreDatabase(String uid) async {
    try {
      await kUsersCollectionReference.doc(_currentUser.uid).collection('reports').doc(uid).delete().timeout(Duration(seconds: 5));
      return ResultMessage(code: '1', message: 'Report Deleted Successfully');
    } on PlatformException catch (e) {
      return ResultMessage(code: '2', message: e.message ?? 'Unknown Platform Error');
    } on TimeoutException catch (_) {
      return ResultMessage(code: '3', message: 'Connection Timeout');
    } on SocketException catch (e) {
      return ResultMessage(code: '4', message: e.message ?? 'Unknown socket error');
    } catch (_) {
      return ResultMessage(code: '5', message: 'Unknown Error');
    }
  }

  Future<String> changeBasicInfo(String property, String content) async {
    try {
      await kUsersCollectionReference.doc(_currentUser.uid).update({
        property: content,
      }).timeout(Duration(seconds: 2));
      if (property == 'name')
        _currentUser.name = content;
      else {
        _currentUser.dob = content;
        _currentUser.age = LocalUser.findAge(content);
      }
      notifyListeners();
      return 'Information Updated';
    } on TimeoutException catch(_) {
      return 'Connection Timeout';
    } on PlatformException catch(e) {
      return e.message ?? 'Unknown Platform Error';
    } on SocketException catch(e) {
      return e.message ?? 'Unknown socket error';
    } catch (_) {
      return 'Unknown Error';
    }
  }

  /// Update `Email` with newEmail
  ///
  /// This is a security sensitive operation requires user to have recently signed in. So it requires `AuthCredentials`
  ///
  /// AuthCredential credential = EmailAuthProvider.getCredential(email: currentEmail, password: currentPassword);
  Future<ResultMessage> updateEmail(String newEmail, AuthCredential credential) async {
    try {
      User user = FirebaseAuth.instance.currentUser;
      await user.reauthenticateWithCredential(credential).timeout(Duration(seconds: 5));
      await user.updateEmail(newEmail).timeout(Duration(seconds: 5));
      return ResultMessage(code: '1', message: 'Email Updated Successfully');
    } on TimeoutException catch(_) {
      return ResultMessage(code: '2', message: 'Connection Timeout');
    } on PlatformException catch(e) {
      return ResultMessage(code: '3', message: e.message ?? 'Unknown Platform Error');
    } on SocketException catch (e) {
      return ResultMessage(code: '4', message: e.message ?? 'Unknown socket error');
    } catch (_) {
      return ResultMessage(code: '5', message: 'Unknown Error');
    }
  }

  /// Update `Password` with newPassword
  ///
  /// This is a security sensitive operation requires user to have recently signed in. So it requires `AuthCredentials`
  ///
  /// AuthCredential credential = EmailAuthProvider.getCredential(email: currentEmail, password: currentPassword);
  Future<ResultMessage> updatePassword(String newPassword, AuthCredential credential) async {
    try {
      User user = FirebaseAuth.instance.currentUser;
      await user.reauthenticateWithCredential(credential).timeout(Duration(seconds: 5));
      user.updatePassword(newPassword).timeout(Duration(seconds: 5));
      return ResultMessage(code: '1', message: 'Password Updated Successfully');
    } on TimeoutException catch(_) {
      return ResultMessage(code: '2', message: 'Connection Timeout');
    } on PlatformException catch(e) {
      return ResultMessage(code: '3', message: e.message ?? 'Unknown Platform Error');
    } on SocketException catch (e) {
      return ResultMessage(code: '4', message: e.message ?? 'Unknown socket error');
    } catch (_) {
      return ResultMessage(code: '5', message: 'Unknown Error');
    }
  }
}
