import 'package:flutter/material.dart';
import 'package:posture_coach/constants.dart';
import 'package:posture_coach/screens/exercises_screen.dart';
import 'package:camera/camera.dart';

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
        primaryColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ExercisesScreen(),
        '/bicep': (context) => bicepCurlExerciseScreen,
        '/raise': (context) => shoulderFrontRaiseExerciseScreen,
        '/press': (context) => shoulderPressExerciseScreen,
        '/shrug': (context) => shrugExerciseScreen,
        'bicep/bicepmod': (context) => bicepCurlModelScreen,
        'raise/raisemod': (context) => shoulderFrontRaiseModelScreen,
        '/press/pressmod': (context) => shoulderPressModelScreen,
        'shrug/shrugmod': (context) => shrugModelScreen,
      },
    );
  }
}
