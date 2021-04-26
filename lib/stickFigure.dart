import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// MyPainter is used to draw the sticky figure
class MyPainter extends CustomPainter {
  static const platform = const MethodChannel('ondeviceML');

  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  var prev;
  var cur;
  var _x;
  var _y;

  var pointPair;

  MyPainter({
    this.results,
    this.previewH,
    this.previewW,
    this.screenH,
    this.screenW,
  });

  getExactCoordinates(var point) {
    _x = point["x"];
    _y = point["y"];
    var scaleW, scaleH, x, y;
    if (screenH / screenW > previewH / previewW) {
      scaleW = screenH / previewH * previewW;
      scaleH = screenH;
      var difW = (scaleW - screenW) / scaleW;
      x = (_x - difW / 2) * scaleW;
      y = _y * scaleH;
    } else {
      scaleH = screenW / previewW * previewH;
      scaleW = screenW;
      var difH = (scaleH - screenH) / scaleH;
      x = _x * scaleW;
      y = (_y - difH / 2) * scaleH;
    }
    x = screenW - x;

    point["x"] = x;
    point["y"] = y;
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

    var numbers = [5, 6, 7, 8, 9, 10, 11, 13, 15, 12, 14, 16];
    for (var i in numbers) getExactCoordinates(results[0]["keypoints"][i]);

    drawSkeleton(
        results[0]["keypoints"][5], results[0]["keypoints"][6], paint, canvas);

    drawSkeleton(
        results[0]["keypoints"][7], results[0]["keypoints"][5], paint, canvas);

    drawSkeleton(
        results[0]["keypoints"][6], results[0]["keypoints"][8], paint, canvas);

    drawSkeleton(
        results[0]["keypoints"][9], results[0]["keypoints"][7], paint, canvas);

    drawSkeleton(
        results[0]["keypoints"][8], results[0]["keypoints"][10], paint, canvas);

    drawSkeleton(
        results[0]["keypoints"][12], results[0]["keypoints"][6], paint, canvas);

    drawSkeleton(results[0]["keypoints"][14], results[0]["keypoints"][12],
        paint, canvas);

    drawSkeleton(results[0]["keypoints"][14], results[0]["keypoints"][16],
        paint, canvas);

    drawSkeleton(results[0]["keypoints"][11], results[0]["keypoints"][12],
        paint, canvas);

    drawSkeleton(
        results[0]["keypoints"][5], results[0]["keypoints"][11], paint, canvas);

    drawSkeleton(results[0]["keypoints"][11], results[0]["keypoints"][13],
        paint, canvas);

    drawSkeleton(results[0]["keypoints"][13], results[0]["keypoints"][15],
        paint, canvas);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return true;
  }
}
