import 'package:flutter/material.dart';

class BicepModelScreen extends StatefulWidget {
  @override
  _BicepModelScreenState createState() => _BicepModelScreenState();
}

class _BicepModelScreenState extends State<BicepModelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bicep Model Screen',
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
