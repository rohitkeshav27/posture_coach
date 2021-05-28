import 'package:flutter/material.dart';
import 'package:posture_coach/screens/exercise_screen.dart';
import 'package:video_player/video_player.dart';

class ButtonOnScreen extends StatelessWidget {
  ButtonOnScreen({@required this.routeTo});

  final String routeTo;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.95,
      child: ElevatedButton(
          onPressed: () {
            Navigator.restorablePushNamed(context, routeTo);
          },
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.teal,
            textStyle: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
            onPrimary: Colors.teal,
            primary: Colors.white,
            padding: EdgeInsets.only(
                left: 100.0, right: 100.0, top: 10.0, bottom: 10.0),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
          child: Text('Try it Now!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ))),
    );
  }
}
