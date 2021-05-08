import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posture_coach/keypointConstants.dart';
import 'package:posture_coach/metrics.dart';

class Poses {
  Map<dynamic,dynamic> evaluate(KeyPointConstants keyPoints, var imageHeight, var imageWidth, var counter) {}
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
      case "Tricep Extension": return TricepExtension();
      break;
      default: return null;
    }
  }
}

class JointCompletion extends StatelessWidget {
  final Map<dynamic,dynamic> results;
  final double height;
  final double width;

  const JointCompletion({
    this.results,
    this.height,
    this.width
});

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderCompletions() {
      var lists = <Widget>[];
      if(results.isNotEmpty) {
        var list = results["keypoints"].map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var x, y;

          x = _x * width;
          y = _y * height;
          // To solve mirror problem on front camera
          x = width - x;

          int green;
          int red;
          double score;
          if (k["type"] == metricType.dynamic) {
            score = k["completion"].toDouble();
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
