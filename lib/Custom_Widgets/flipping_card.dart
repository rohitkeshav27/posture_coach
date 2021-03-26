import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:posture_coach/constants.dart';

class FlippingCard extends StatelessWidget {
  FlippingCard({@required this.front_info, @required this.back_info});

  final String front_info;
  final String back_info;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.70,
      child: Card(
        elevation: 0.0,
        color: Colors.black,
        child: FlipCard(
          direction: FlipDirection.HORIZONTAL,
          speed: 1000,
          onFlipDone: (status) {
            print(status);
          },
          front: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 5.0),
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(front_info, style: kbicep_info_style),
                ),
              ],
            ),
          ),
          back: Container(
            width: 400.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 5.0),
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(back_info, style: kbicep_info_style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
