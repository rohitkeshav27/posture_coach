import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Poses {
  Map<int,Map<String,double>> evaluate(var recognitions) {}
}

class PosesFactory {
  static Poses getPose(String poseName) {
    switch (poseName) {
      case "Bicep Curl": return BicepCurl();
      break;
      case "Shoulder Press": return ShoulderPress();
      break;
      default: return null;
    }
  }
}

class BicepCurl implements Poses {
  Map<int,Map<String,double>> evaluate(var recognitions) {
    print("Bicep curl evaluate");
    var result = Map<int,Map<String,double>>();
    var innerResult = Map<String,double>();
    innerResult["x"] = recognitions[0]["keypoints"][8]["x"];
    innerResult["y"] = recognitions[0]["keypoints"][8]["y"];
    innerResult["completion"] = 0.75;
    result[8] = innerResult;
    return result;
  }
}

class ShoulderPress implements Poses {
  Map<int,Map<String,double>> evaluate(var recognitions) {
    print("Shoulder Press evaluate");
    var result = Map();
    result[8] = Map();
    result[8]["x"] = recognitions[0]["keypoints"][8]["x"];
    result[8]["y"] = recognitions[0]["keypoints"][8]["y"];
    result[8]["completion"] = 0.5; //TODO: Calculate completion value
    return result;
  }
}

class JointCompletion extends StatelessWidget {
  final Map<int,Map<String,double>> results;
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
        var list = results.values.map((k) {
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

          return Positioned(
              left: x,
              top: y,
              child: CircularProgressIndicator(
                value: k["completion"],
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
