import 'package:flutter/material.dart';

class PressModelScreen extends StatefulWidget {
  @override
  _PressModelScreenState createState() => _PressModelScreenState();
}

class _PressModelScreenState extends State<PressModelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Shoulder Press Model Screen',
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
