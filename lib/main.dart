import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:posture_coach/screens/exercise_inventory_screen.dart';
import 'package:posture_coach/Exercises/exercise.dart';
import 'package:posture_coach/screens/exercise_model_screen.dart';
import 'package:posture_coach/screens/exercise_screen.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posture Coach',
      theme: ThemeData(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ExerciseInventoryScreen(),
        '/bicep': (context) => ExerciseScreen(exercise: exercises[0]),
        '/raise': (context) => ExerciseScreen(exercise: exercises[1]),
        '/press': (context) => ExerciseScreen(exercise: exercises[2]),
        '/tricepExtension': (context) => ExerciseScreen(exercise: exercises[3]),
        '/bicep/bicepmod': (context) => ExerciseModelScreen(
            exerciseName: exercises[0].name, cameras: cameras),
        '/raise/raisemod': (context) => ExerciseModelScreen(
            exerciseName: exercises[1].name, cameras: cameras),
        '/press/pressmod': (context) => ExerciseModelScreen(
            exerciseName: exercises[2].name, cameras: cameras),
        '/tricepExtension/tricepExtensionmod': (context) => ExerciseModelScreen(
            exerciseName: exercises[3].name, cameras: cameras),
      },
    );
  }
}
