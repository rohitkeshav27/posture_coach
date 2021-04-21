import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<dynamic> _inputArr = [];

// MyPainter is used to draw the sticky figure
class MyPainter extends CustomPainter {
  static const platform = const MethodChannel('ondeviceML');

  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  var prev=null;
  var cur = null;
  var _x =null;
  var _y = null;

   MyPainter({
    this.results,
    this.previewH,
    this.previewW,
    this.screenH,
    this.screenW,
  });

   getExactCoordinates(var point){
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
     if (x > 320) {
       var temp = x - 320;
       x = 320 - temp;
     } else {
       var temp = 320 - x;
       x = 320 + temp;
     }

     x= x-230;
     y = y-50;
         print(x);
         print(y);
     point["x"] =x;
     point["y"] =y;
   }

void drawskeleton( var part1,var part2,Paint paint, Canvas canvas){
  print("inside draw");

  print(part1["x"]);
  print(part1["y"]);
  print(part2["x"]);
  print(part2["y"]);
  final p1 = Offset(part1["x"], part1["y"]);
  final p2 = Offset(part2["x"], part2["y"]);
  // if((part1["part"] == "rightShoulder" && part2["part"]=="leftShoulder")
  //     || (part2["part"] == "rightShoulder" && part1["part"]=="leftShoulder")
  //     || (part1["part"] == "rightShoulder" && part2["part"]=="rightElbow")
  //     || (part1["part"] == "rightElbow" && part2["part"]=="rightShoulder")
  //     || (part1["part"] == "rightWrist" && part2["part"]=="rightElbow")
  //     || (part1["part"] == "rightElbow" && part2["part"]=="rightWrist"))
    canvas.drawLine(p1, p2, paint);
}



  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5;
    List<var,var>
    prev = results[0]["keypoints"][5];
    cur = results[0]["keypoints"][6];
    getExactCoordinates(prev);
    getExactCoordinates(cur);
    if (prev != null || cur != null) {
      drawskeleton(prev, cur, paint, canvas);
    }
  }

@override
bool shouldRepaint(MyPainter oldDelegate) {
  return true;
}
}