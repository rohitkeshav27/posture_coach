import 'package:flutter/material.dart';

class ExerciseModelScreen extends StatefulWidget {
  @override
  final String exercise_name;
  const ExerciseModelScreen({Key key, this.exercise_name}) : super(key: key);
  _ExerciseModelScreenState createState() => _ExerciseModelScreenState();
}

class _ExerciseModelScreenState extends State<ExerciseModelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.exercise_name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
