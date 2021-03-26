import 'package:flutter/material.dart';

class ShrugModelScreen extends StatefulWidget {
  @override
  _ShrugModelScreenState createState() => _ShrugModelScreenState();
}

class _ShrugModelScreenState extends State<ShrugModelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Shrug Model Screen',
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
