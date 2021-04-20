import 'package:flutter/material.dart';

class ButtonOnScreen extends StatelessWidget {
  ButtonOnScreen({@required this.routeto});
  final String routeto;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.95,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, routeto);
          },
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.red,
            textStyle: TextStyle(
              fontFamily: 'Granite',
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
            onPrimary: Colors.red,
            primary: Colors.white,
            padding: EdgeInsets.only(
                left: 100.0, right: 100.0, top: 10.0, bottom: 10.0),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
          child: Text('Grind   Now',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ))),
    );
  }
}
