import 'dart:math';

import 'package:posture_coach/keypointConstants.dart';
import 'package:posture_coach/poses.dart';
import 'package:posture_coach/skeleton.dart';

/*
    {
    isStepCompleted: Bool,
    keypoints: [ { "x":double, "y":double, "completion":double(range 0-1), "type":metricType, "message":String} , {} ],
    partsToDisplay: [ [keypointA,keypointB] , [keypointC,keypointD] ],
    }
*/
//TODO: Differentiate between static and dynamic metrics visually ?
//TODO: Lateral raise ?
enum metricType { static, dynamic }

class BicepCurl implements Poses {
  Map<dynamic, dynamic> evaluate(KeyPointConstants keyPoints, var imageHeight,
      var imageWidth, var counter) {
    print("Bicep curl evaluate");
    //TODO: Perspective Detection
    var result = Map<String, dynamic>();
    var keyPointList = [];
    var skeleton = new Skeleton(keyPoints, imageHeight, imageWidth);

    var shoulder,elbow,wrist,hip;
    if(keyPoints.rightWrist["score"]+keyPoints.rightElbow["score"]+keyPoints.rightShoulder["score"] >
        keyPoints.leftWrist["score"]+keyPoints.leftElbow["score"]+keyPoints.leftShoulder["score"]) {
      shoulder = keyPoints.rightShoulder;
      wrist = keyPoints.rightWrist;
      elbow = keyPoints.rightElbow;
      hip = keyPoints.rightHip;
    } else {
      shoulder = keyPoints.leftShoulder;
      wrist = keyPoints.leftWrist;
      elbow = keyPoints.leftElbow;
      hip = keyPoints.leftHip;
    }
    var elbowAngle = skeleton.getAngleBetween(shoulder, elbow, wrist);
    var elbowMetric = Map<String, dynamic>();
    elbowMetric["x"] = elbow["x"];
    elbowMetric["y"] = elbow["y"];
    elbowMetric["type"] = metricType.dynamic;
    if (elbowAngle < 40.0) {
      elbowMetric["completion"] = counter % 2 == 0 ? 1 : 0;
    } else if (elbowAngle > 165.0) {
      elbowMetric["completion"] = counter % 2 == 0 ? 0 : 1;
    } else {
      elbowMetric["completion"] = counter % 2 == 0
          ? 1 - ((elbowAngle - 40) / (165 - 40))
          : ((elbowAngle - 40) / (165 - 40));
    }
    elbowMetric["message"] = counter % 2 == 0 ? "Please raise your arm completely" : "Please lower your arm completely";
    keyPointList.add(elbowMetric);

    var shoulderAngle = skeleton.getAngleBetween(hip, shoulder, elbow);
    var shoulderMetric = Map<String, dynamic>();
    shoulderMetric["x"] = shoulder["x"];
    shoulderMetric["y"] = shoulder["y"];
    shoulderMetric["type"] = metricType.static;
    shoulderMetric["completion"] = shoulderAngle < 35.0 ? 1 : 0;
    shoulderMetric["message"] = "Please keep your upper arm close to your body";
    keyPointList.add(shoulderMetric);

    var flag = true;
    keyPointList.forEach((metric) {
      if (metric["completion"] != 1) {
        flag = false;
      }
    });
    result["isStepCompleted"] = flag;

    var partsToDisplay = [
      [shoulder, elbow],
      [elbow, wrist],
    ];
    result["partsToDisplay"] = partsToDisplay;

    result["keypoints"] = keyPointList;
    return result;
  }
}

class ShoulderPress implements Poses {
  Map<dynamic, dynamic> evaluate(
      KeyPointConstants keyPoints, var imageHeight, var imageWidth, var counter) {
    print("Shoulder Press evaluate");
    var result = Map<String, dynamic>();
    var keyPointList = [];
    var skeleton = new Skeleton(keyPoints, imageHeight, imageWidth);

    return result;
  }
}

class ShoulderFrontRaise implements Poses {
  Map<dynamic, dynamic> evaluate(
      KeyPointConstants keyPoints, var imageHeight, var imageWidth, var counter) {
    print("Shoulder Press evaluate");
    var result = Map<String, dynamic>();
    var keyPointList = [];
    var skeleton = new Skeleton(keyPoints, imageHeight, imageWidth);

    return result;
  }
}

class TricepExtension implements Poses {
  Map<dynamic, dynamic> evaluate(
      KeyPointConstants keyPoints, var imageHeight, var imageWidth, var counter) {
    print("Tricep Extension evaluate");
    var result = Map<String, dynamic>();
    var keyPointList = [];
    var skeleton = new Skeleton(keyPoints, imageHeight, imageWidth);

    return result;
  }
}
