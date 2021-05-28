import 'package:flutter/material.dart';
import 'package:posture_coach/image_container.dart';
import 'package:posture_coach/Custom_Widgets/verticalpager.dart';

class ExerciseInventoryScreen extends StatelessWidget {
  final List<String> titles = [
    "Bicep Curl",
    "Shoulder Front Raise",
    "Shoulder Press",
    "Squats",
  ];

  final List<Widget> images = [
    ImageContainer(
      path: 'images/BicepCurl.png',
      routeName: '/bicep',
    ),
    ImageContainer(
      path: 'images/FrontRaise.png',
      routeName: '/raise',
    ),
    ImageContainer(
      path: 'images/shoulderPress.png',
      routeName: '/press',
    ),
    ImageContainer(
      path: 'images/squats.png',
      routeName: '/squats',
    )
  ];

  final List<String> routeName = ['/bicep', '/raise', '/press', '/squats'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
        'Posture Coach',
        style: TextStyle(
          color: Colors.white,
        ),
      ))),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: VerticalCardPager(
                      titles: titles,
                      // required
                      images: images,
                      // required
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontFamily: 'Acetone',
                          fontWeight: FontWeight.w600),
                      // optional
                      onPageChanged: (page) {
                        // optional
                      },
                      onSelectedItem: (index) {
                        Navigator.pushNamed(context, routeName[index]);
                      },
                      initialPage: 0,
                      // optional
                      align: ALIGN.CENTER // optional
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
