import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// BndBox is used to draw the key points
class BndBox extends StatelessWidget {
  static const platform = const MethodChannel('ondeviceML');

  final List<dynamic> results;
  final double height;
  final double width;

  const BndBox({this.results, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      results.forEach((re) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var x, y;

          x = _x * width;
          y = _y * height;
          // To solve mirror problem on front camera
          x = width - x;

          return Positioned(
            left: x,
            top: y,
            child: Container(
                child: Stack(children: [
              Text(
                "● ${k["part"]}",
                style: TextStyle(
                  color: Color.fromRGBO(37, 213, 253, 1.0),
                  fontSize: 12.0,
                ),
              )
            ])),
          );
        }).toList();

        lists..addAll(list);
      });
      return lists;
    }

    return Stack(children: _renderKeypoints());
  }
}
