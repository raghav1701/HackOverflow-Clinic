import 'dart:async';
import 'package:bug_busters/handlers/snackBar.dart';
import 'package:bug_busters/models/user.dart';
import 'package:bug_busters/services/firestore.dart';
import 'package:bug_busters/shared/functions.dart';
import 'package:bug_busters/shared/routes.dart';
import 'package:bug_busters/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WrapperBody(),
      ),
    );
  }
}

class WrapperBody extends StatefulWidget {
  @override
  _WrapperBodyState createState() => _WrapperBodyState();
}

class _WrapperBodyState extends State<WrapperBody> {

  bool loading;

  void verifyAuthentication() async {
    setState(() => loading = true);
    try {
      User user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final internet = await checkInternetConnectivity();
        if (internet.code != '1') {
          throw internet.message;
        }
        await user.reload().timeout(Duration(seconds: 10));
        final snapshot = await FirestoreService.kUsersCollectionReference.doc(user.uid).get();
        Map result = snapshot.data();

        final LocalUser newUser = LocalUser(
          uid: user.uid,
          email: user.email,
          name: result['name'],
          dob: result['dob'],
          gender: result['gender']
        );
        Provider.of<FirestoreService>(context, listen: false).setUser(newUser);
        Navigator.pushReplacementNamed(context, dashboard);
      } else {
        await Future.delayed(Duration(milliseconds: 1000));
        Navigator.pushReplacementNamed(context, login);
      }
    } on TimeoutException catch (_) {
      setState(() => loading = false);
      loading = false;
      handleSnackBar(
        context: context,
        message: 'Connection Timeout',
      );
    } on PlatformException catch (e) {
      setState(() => loading = false);
      handleSnackBar(
        context: context,
        message: e.message ?? 'Unknown Platform Error',
      );
    } catch (e) {
      setState(() => loading = false);
      handleSnackBar(
        context: context,
        message: e.toString() ?? 'Unknown Error',
      );
    }
  }

  void auth() async {
    await Firebase.initializeApp().whenComplete(() {
      verifyAuthentication();
    });
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    auth();
  }

  @override
  Widget build(BuildContext context) {
    return Splash(
      loading: loading,
      retry: verifyAuthentication,
    );
  }
}
