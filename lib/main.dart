import 'package:bug_busters/models/app.dart';
import 'package:bug_busters/services/firestore.dart';
import 'package:bug_busters/shared/routes.dart';
import 'package:bug_busters/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(BugBusters());
}

class BugBusters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => FirestoreService(),
        ),
      ],
      child: MaterialApp(
        title: AppDetails.name,
        debugShowCheckedModeBanner: false,
        theme: kdefaultTheme,
        initialRoute: wrapper,
        routes: routes,
      ),
    );
  }
}
