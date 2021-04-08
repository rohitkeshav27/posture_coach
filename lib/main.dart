import 'package:flutter/material.dart';
import 'package:posture_coach/constants.dart';
import 'package:posture_coach/screens/excercises_screeen.dart';

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
        '/bicep': (context) => bicep_exercise_screen,
        '/raise': (context) => raise_exercise_screen,
        '/press': (context) => press_exercise_screen,
        '/shrug': (context) => shrug_exercise_screen,
        'bicep/bicepmod': (context) => bicep_model_screen,
        'raise/raisemod': (context) => raise_model_screen,
        '/press/pressmod': (context) => press_model_screen,
        'shrug/shrugmod': (context) => shrug_model_screen,
      },
    );
  }
}
