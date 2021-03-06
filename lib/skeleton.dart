import 'dart:math';

import 'keypointConstants.dart';

class Skeleton {
  Map<String, double> bodyPart;
  int imageHeight;
  int imageWidth;
  var normalizationConstant;

  Skeleton(KeyPointConstants keyPoints, imageHeight, imageWidth) {
    this.imageHeight = imageHeight;
    this.imageWidth = imageWidth;
    bodyPart = new Map();
    getLengths(keyPoints);
    normalize(keyPoints);
  }

  void getLengths(KeyPointConstants keyPoints) {
    bodyPart["shoulderLength"] =
        straightLineDistance(keyPoints.leftShoulder, keyPoints.rightShoulder);
    bodyPart["hipLength"] =
        straightLineDistance(keyPoints.leftHip, keyPoints.rightHip);
    bodyPart["rightTorsoLength"] =
        straightLineDistance(keyPoints.rightShoulder, keyPoints.rightHip);
    bodyPart["leftTorsoLength"] =
        straightLineDistance(keyPoints.leftShoulder, keyPoints.leftHip);
  }

  void normalize(KeyPointConstants keyPoints) {
    normalizationConstant =
        (bodyPart["rightTorsoLength"] + bodyPart["leftTorsoLength"]) / 2;
    // var normalizationConstant = straightLineDistance(midPoint(recognitions[0]["keypoints"][5], recognitions[0]["keypoints"][6]), midPoint(recognitions[0]["keypoints"][11], recognitions[0]["keypoints"][12]));
    // bodyPart.forEach((key, value) {
    //   bodyPart.update(key, (value) => value/normalizationConstant);
    // });
    // print("constant = "+normalizationConstant.toString());
  }

  // Geometric functions

  double straightLineDistance(var p1, var p2) {
    return sqrt(pow((p1["x"] - p2["x"]), 2) + pow((p1["y"] - p2["y"]), 2));
  }

  Map<String, double> midPoint(var p1, var p2) {
    return {"x": (p1["x"] + p2["x"]) / 2, "y": (p1["y"] + p2["y"]) / 2};
  }

  // void display() {
  //   bodyPart.forEach((key, value) {
  //     print(key + "\t" + value.toString());
  //   });
  // }

  double getAngleBetween(var p1, var p2, var p3) {
    p1 = getActualCoordinates(p1);
    p2 = getActualCoordinates(p2);
    p3 = getActualCoordinates(p3);
    // print("actual coordinates");
    // print(p1["x"].toString() + "," + p1["y"].toString());
    // print(p2["x"].toString() + "," + p2["y"].toString());
    // print(p3["x"].toString() + "," + p3["y"].toString());

    // mathematical function to calculate the angle
    // arccos((P12^2 + P23^2 - P13^2) / (2 * P12 * P23))

    var p12 = straightLineDistance(p1, p2); //normalizationConstant;
    var p23 = straightLineDistance(p2, p3); //normalizationConstant;
    var p31 = straightLineDistance(p3, p1); //normalizationConstant;
    // print("distances");
    // print("p12 : " + p12.toString());
    // print("p23 : " + p23.toString());
    // print("p31 : " + p31.toString());
    return acos((pow(p12, 2) + pow(p23, 2) - pow(p31, 2)) / (2 * p12 * p23)) *
        (180 / pi);
  }

  Map<dynamic, dynamic> getActualCoordinates(var p) {
    return {
      "x": p["x"] * min(imageHeight, imageWidth),
      "y": p["y"] * max(imageHeight, imageWidth)
    };
  }
}
