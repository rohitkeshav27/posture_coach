import 'package:flutter/material.dart';

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
            shadowColor: Color(0xFF4e0004),
            elevation: 15,
            textStyle: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
            onPrimary: Colors.white,
            primary: Color(0xFF9a0007),
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
