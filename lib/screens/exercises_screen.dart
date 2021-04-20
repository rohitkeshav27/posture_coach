import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:posture_coach/image_container.dart';

import '../constants.dart';

class ExercisesScreen extends StatelessWidget {

  final List<Widget> images = [
    ImageContainer(
      path: 'images/Bicep_curl.jpg',
      routeName: '/bicep',
    ),
    ImageContainer(
      path: 'images/Front_raise.jpg',
      routeName: '/raise',
    ),
    ImageContainer(
      path: 'images/Shoulder_Press.jpg',
      routeName: '/press',
    ),
    ImageContainer(
      path: 'images/Shrugs.jpg',
      routeName: '/shrugs',
    )
  ];

  final List<String> routeName = ['/bicep', '/raise', '/press', '/shrug'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
        'List of Exercises',
        style: TextStyle(
          color: Colors.red,
        ),
      ))),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bg1.jpg'), fit: BoxFit.cover)),
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
                          color: Colors.grey[350],
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
