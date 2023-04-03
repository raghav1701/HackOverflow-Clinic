import 'package:bug_busters/screens/drawer.dart';
import 'package:bug_busters/shared/constants.dart';
import 'package:bug_busters/shared/routes.dart';
import 'package:bug_busters/themes/decoration.dart';
import 'package:bug_busters/widgets/buttons.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final List<String> images = [
    kAssetImages + '/heart.png',
    kAssetImages + '/liver.png',
    kAssetImages + '/sugar.png',
    kAssetImages + '/eye.png',
    kAssetImages + '/ear.png',
  ];

  final List<String> routes = [
    heartTest,
    liverTest,
    sugarTest,
    eyeTest,
    earTest,
    history,
    settings,
  ];

  void handleButtonTaps(BuildContext context, int index) {
    Navigator.pushNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthsy'),
        actions: [
          IconButton(
            icon: Icon(Icons.book),
            onPressed: () => handleButtonTaps(context, 5),
          ),
          InkWell(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  kSplashCrop,
                ),
                radius: 15.0,
              ),
              radius: 18.0,
            ),
            onTap: () => handleButtonTaps(context, 6),
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
      backgroundColor: kThemeGroundColor,
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [0,2].map((index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: SquareButton(
                            image: images[index],
                            action: () => handleButtonTaps(context, index),
                          ),
                        ),
                        Flexible(
                          child: SquareButton(
                            image: images[index+1],
                            action: () => handleButtonTaps(context, index+1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                );
              }).toList()
              ..addAll(
                [4].map((index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: SquareButton(
                              image: images[index],
                              action: () => handleButtonTaps(context, index),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Text(
                        '👆 Tap on a button above to start a test.',
                        style: kDefaultTextStyle.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            )
          );
        }),
      ),
      drawer: AppDrawer(),
    );
  }
}
