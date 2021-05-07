import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posture_coach/metrics.dart';

class Poses {
  Map<dynamic,dynamic> evaluate(var recognitions, var imageHeight, var imageWidth, var counter) {}
}

class PosesFactory {
  static Poses getPose(String poseName) {
    switch (poseName) {
      case "Bicep Curl": return BicepCurl();
      break;
      case "Shoulder Press": return ShoulderPress();
      break;
      case "Shoulder Front Raise": return ShoulderFrontRaise();
      break;
      case "Shrugs": return Shrugs();
      break;
      default: return null;
    }
  }
}

class JointCompletion extends StatelessWidget {
  final Map<dynamic,dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;

  const JointCompletion({
    this.results,
    this.previewH,
    this.previewW,
    this.screenH,
    this.screenW,
});

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderCompletions() {
      var lists = <Widget>[];
      if(results.isNotEmpty) {
        var list = results["keypoints"].map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
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

          // To solve mirror problem on front camera
          x = screenW - x;

          int green;
          int red;
          double score;
          if (k["type"] == 1.0) {
            score = k["completion"];
            if (score < 0.5) {
              red = 255;
              green = (score * 2 * 255).toInt();
            } else {
              red = 255 - (score * 2 * 255).toInt();
              green = 255;
            }
          } else {
            score = 1;
            if (k["completion"] == 1.0) {
              green = 255;
              red = 0;
            } else {
              green = 0;
              red = 255;
            }
          }

          return Positioned(
              left: x,
              top: y,
              //TODO: https://www.syncfusion.com/blogs/post/create-stunning-circular-progress-bars-with-flutter-radial-gauge-part-1.aspx
              child: CircularProgressIndicator(
                value: score,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
                valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(red, green, 0, 1.0)),
                strokeWidth: 8.0,
              )
          );
        }).toList();

        lists..addAll(list);
      }
      return lists;
    }
    return Stack(children: _renderCompletions());
  }
}
