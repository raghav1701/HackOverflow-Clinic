import 'dart:async';
import 'dart:io';
import 'package:bug_busters/handlers/snackBar.dart';
import 'package:bug_busters/models/user.dart';
import 'package:bug_busters/models/message.dart';
import 'package:bug_busters/services/firestore.dart';
import 'package:bug_busters/shared/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AuthenticationService {
  /// `User Email`
  final String email;

  /// `User Password`
  final String password;

  /// The `function` to trigger when `waiting` for the completion of operation
  ///
  /// This can be used to toggle states between loading and not loading
  final Function waiting;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationService({
    @required this.email,
    @required this.password,
    @required this.waiting,
  });

  /// This function will sign in the user with email and password
  void signInUserWithEmailAndPassword(BuildContext context) async {
    waiting(true);
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password).timeout(Duration(seconds: 10));
      final User user = result.user;
      if (user != null) {
        final snapshot = await FirestoreService.kUsersCollectionReference.doc(user.uid).get().timeout(Duration(seconds: 5));
        final data = snapshot.data();
        final LocalUser newUser = LocalUser(
          uid: user.uid,
          email: user.email,
          name: data['name'],
          dob: data['dob'],
          gender: data['gender'],
        );
        Provider.of<FirestoreService>(context, listen: false).setUser(newUser);
        Navigator.pushReplacementNamed(context, dashboard);
      }
      else {
        throw 'error';
      }
    } on PlatformException catch (e) {
      handleSnackBar(context: context, message: e.message ?? 'Unknown Platform Error');
    } on TimeoutException catch (_) {
      handleSnackBar(context: context, message: 'Connection Timeout');
    } on SocketException catch (e) {
      handleSnackBar(context: context, message: e.message ?? 'Unknown Socket Error');
    } catch (e) {
      handleSnackBar(context: context, message: e.toString());
    } finally {
      waiting(false);
    }
  }

  /// This function will create a new user in firebase with email and password
  void registerNewUserWithEmailAndPassword(BuildContext context, String name, String dob, String gender) async {
    waiting(true);
    try {
      final UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final User user = result.user;
      if (user != null) {
        User user = FirebaseAuth.instance.currentUser;
        LocalUser newUser = LocalUser(
          uid: user.uid,
          email: user.email,
          name: name,
          dob: dob,
          gender: gender,
        );
        Provider.of<FirestoreService>(context, listen: false).setUser(newUser);
        ResultMessage result = await Provider.of<FirestoreService>(context, listen: false).createNewUserDatabase();
        waiting(false);
        if (result.code != '1') {
          handleSnackBar(context: context, message: result.message);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, dashboard, (route) => false);
        }
      }
      else
        throw 'error';
    } on PlatformException catch (e) {
      handleSnackBar(context: context, message: e.message ?? 'Unknown Platform Error');
    } on TimeoutException catch (_) {
      handleSnackBar(context: context, message: 'Connection Timeout');
    } on SocketException catch (e) {
      handleSnackBar(context: context, message: e.message ?? 'Unknown Socket Error');
    } catch (_) {
      handleSnackBar(context: context, message: 'Unknown error while registering new user');
    } finally {
      waiting(false);
    }
  }
}
