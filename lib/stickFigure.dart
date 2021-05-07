import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'keypointConstants.dart';

// MyPainter is used to draw the sticky figure
class MyPainter extends CustomPainter {
  static const platform = const MethodChannel('ondeviceML');

  final KeyPointConstants results;
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
    if (screenH / screenW < previewH / previewW) {
      scaleW = screenH / previewH * previewW;
      scaleH = screenH;
      var difW = (scaleW - screenW) / scaleW;
      x = (_x - difW / 2) * scaleW;
      y = _y * scaleH;
    } else {
      scaleH = screenW / previewW * previewH;
      scaleW = screenW;
      var difH = 0; // (scaleH - screenH) / scaleH;
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
    if(results ==null){
      print("null found in paint");
      return;
    }
    var paint = Paint()
      ..color = Color.fromRGBO(37, 213, 253, 1.0)
      ..strokeWidth = 5;

    var bodyPoints = [
      results.leftShoulder,
      results.rightShoulder,
      results.leftElbow,
      results.rightElbow,
      results.leftWrist,
      results.rightWrist,
      results.leftHip,
      results.leftKnee,
      results.leftAnkle,
      results.rightHip,
      results.rightKnee,
      results.rightAnkle
    ];
    for (var i in bodyPoints) getExactCoordinates(i);

    // drawSkeleton(
    //     results.leftShoulder, results.rightShoulder, paint, canvas);
    //
    // drawSkeleton(
    //     results.leftElbow, results.leftShoulder, paint, canvas);

    drawSkeleton(
        results.rightShoulder, results.rightElbow, paint, canvas);
    //
    // drawSkeleton(
    //     results.leftWrist, results.leftElbow, paint, canvas);

    drawSkeleton(
        results.rightElbow, results.rightWrist, paint, canvas);

    // drawSkeleton(
    //     results.rightHip, results.rightShoulder, paint, canvas);
    //
    // drawSkeleton(results.rightKnee, results.rightHip,
    //     paint, canvas);
    //
    // drawSkeleton(results.rightKnee, results.rightAnkle,
    //     paint, canvas);
    //
    // drawSkeleton(results.leftHip, results.rightHip,
    //     paint, canvas);
    //
    // drawSkeleton(
    //     results.leftShoulder, results.leftHip, paint, canvas);
    //
    // drawSkeleton(results.leftHip, results.leftKnee,
    //     paint, canvas);
    //
    // drawSkeleton(results.leftKnee, results.leftAnkle,
    //     paint, canvas);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return true;
  }
}
