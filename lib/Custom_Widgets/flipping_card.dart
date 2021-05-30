import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

const flippingCardStyle = TextStyle(
    color: Colors.black, fontWeight: FontWeight.normal, fontSize: 18.0);

class FlippingCard extends StatelessWidget {
  FlippingCard({@required this.frontInfo, @required this.backInfo});

  final String frontInfo;
  final String backInfo;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.70,
      child: Card(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        elevation: 0.0,
        color: Color(0xFFe0e0e0),
        child: FlipCard(
          direction: FlipDirection.HORIZONTAL,
          speed: 1000,
          onFlipDone: (status) {
      //      print(status);
          },
          front: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF9a0007), width: 5.0),
              color: Color(0xFFff6659),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(frontInfo, style: flippingCardStyle),
                ),
              ],
            ),
          ),
          back: Container(
            width: 400.0,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF9a0007), width: 5.0),
              color: Color(0xFFff6659),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(backInfo, style: flippingCardStyle),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
