import 'package:flutter/material.dart';

class RaiseModelScreen extends StatefulWidget {
  @override
  _RaiseModelScreenState createState() => _RaiseModelScreenState();
}

class _RaiseModelScreenState extends State<RaiseModelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Shoulder Raise Model Screen',
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
