import 'package:flutter/material.dart';
import 'package:posture_coach/screens/bicep_screen.dart';
import 'package:posture_coach/screens/excercises_screeen.dart';
import 'package:posture_coach/screens/press_screen.dart';
import 'package:posture_coach/screens/raise_screen.dart';
import 'package:posture_coach/screens/shrug_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ExercisesScreen(),
        '/bicep': (context) => BicepScreen(),
        '/raise': (context) => RaiseScreen(),
        '/press': (context) => PressScreen(),
        '/shrug': (context) => ShrugScreen(),
      },
    );
  }
}
