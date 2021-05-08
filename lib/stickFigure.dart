import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'keypointConstants.dart';

// MyPainter is used to draw the sticky figure
class MyPainter extends CustomPainter {
  static const platform = const MethodChannel('ondeviceML');

  final double height;
  final double width;
  final List<dynamic> partsToDisplay;

  var pointPair;

  MyPainter({
    this.height,
    this.width,
    this.partsToDisplay
  });

  dynamic getExactCoordinates(var point) {
    var out = Map();
    out["x"] = point["x"] * width;
    out["y"] = point["y"] * height;
    out["x"] = width - out["x"];
    out["score"] = point["score"];
    out["part"] = point["part"];
    return out;
  }

  void drawSkeleton(var part1, var part2, Paint paint, Canvas canvas) {
    if (part1["score"] < 0.2 || part2["score"] < 0.2) {
      return;
    } else {
      if (part2["part"] == "rightAnkle") {
        print(part2);
      }
      final p1 = Offset(part1["x"], part1["y"]);
      final p2 = Offset(part2["x"], part2["y"]);
      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {

    var paint = Paint()
      ..color = Color.fromRGBO(37, 213, 253, 1.0)
      ..strokeWidth = 5;

    partsToDisplay.forEach((part) {
      drawSkeleton(getExactCoordinates(part[0]), getExactCoordinates(part[1]), paint, canvas);
    });
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return true;
  }
}
