import 'dart:math';

import 'package:posture_coach/keypointConstants.dart';
import 'package:posture_coach/poses.dart';
import 'package:posture_coach/skeleton.dart';

/*
    {
    isStepCompleted: Bool,
    keypoints: [ { "x":double, "y":double, "completion":double(range 0-1), "type":metricType, "message":String , "confidence":Bool} , {} ],
    partsToDisplay: [ [keypointA,keypointB] , [keypointC,keypointD] ],
    }
*/
enum metricType { static, dynamic }

class BicepCurl implements Poses {
  Map<dynamic, dynamic> evaluate(KeyPointConstants keyPoints, var imageHeight,
      var imageWidth, var counter) {
    print("Bicep curl evaluate");
    var result = Map<String, dynamic>();
    var keyPointList = [];
    var skeleton = new Skeleton(keyPoints, imageHeight, imageWidth);
    const scoreThreshold = 0;

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
    elbowMetric["confidence"] = (wrist["score"] > scoreThreshold && shoulder["score"] > scoreThreshold && elbow["score"] > scoreThreshold);
    elbowMetric["message"] = counter % 2 == 0 ? "Please raise your arm completely" : "Please lower your arm completely";
    keyPointList.add(elbowMetric);

    var shoulderAngle = skeleton.getAngleBetween(hip, shoulder, elbow);
    var shoulderMetric = Map<String, dynamic>();
    shoulderMetric["x"] = shoulder["x"];
    shoulderMetric["y"] = shoulder["y"];
    shoulderMetric["type"] = metricType.static;
    shoulderMetric["completion"] = shoulderAngle < 35.0 ? 1 : 0;
    shoulderMetric["confidence"] = (hip["score"] > scoreThreshold && shoulder["score"] > scoreThreshold && elbow["score"] > scoreThreshold);
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
    const scoreThreshold = 0.5;

    for(var i in ["left","right"]) {
      var hip,shoulder,elbow,wrist;

      if(i == "left") {
        hip = keyPoints.leftHip;
        shoulder = keyPoints.leftShoulder;
        elbow = keyPoints.leftElbow;
        wrist = keyPoints.leftWrist;
      } else {
        hip = keyPoints.rightHip;
        shoulder = keyPoints.rightShoulder;
        elbow = keyPoints.rightElbow;
        wrist = keyPoints.rightWrist;
      }

      var shoulderAngle = skeleton.getAngleBetween(hip, shoulder, elbow);

      var shoulderStaticMetric = Map<String, dynamic>();
      shoulderStaticMetric["x"] = shoulder["x"];
      shoulderStaticMetric["y"] = shoulder["y"];
      shoulderStaticMetric["type"] = metricType.static;
      shoulderStaticMetric["completion"] = shoulderAngle > 70.0 ? 1 : 0;
      shoulderStaticMetric["confidence"] = (hip["score"] > scoreThreshold && shoulder["score"] > scoreThreshold && elbow["score"] > scoreThreshold);
      shoulderStaticMetric["message"] = "Please keep your " + i + "elbow at shoulder level"; //TODO: Check message
      keyPointList.add(shoulderStaticMetric);

      var ghostPoint = Map();
      ghostPoint["x"] = elbow["x"];
      ghostPoint["y"] = elbow["y"] + 50.0;
      var lowerArmAngle = skeleton.getAngleBetween(wrist,elbow,ghostPoint);
      var lowerArmMetric = Map<String, dynamic>();
      lowerArmMetric["x"] = elbow["x"];
      lowerArmMetric["y"] = elbow["y"];
      lowerArmMetric["type"] = metricType.static;
      lowerArmMetric["completion"] = lowerArmAngle > 150.0 ? 1 : 0;
      lowerArmMetric["confidence"] = (wrist["score"] > scoreThreshold && elbow["score"] > scoreThreshold);
      lowerArmMetric["message"] = "Please keep your " + i + " arm vertical";
      keyPointList.add(lowerArmMetric);

      var shoulderDynamicMetric = Map<String, dynamic>();
      shoulderDynamicMetric["x"] = shoulder["x"];
      shoulderDynamicMetric["y"] = shoulder["y"];
      shoulderDynamicMetric["type"] = metricType.dynamic;
      if (shoulderAngle > 155.0) {
        shoulderDynamicMetric["completion"] = counter % 2 == 0 ? 1 : 0;
      } else if (shoulderAngle < 90.0) {
        shoulderDynamicMetric["completion"] = counter % 2 == 0 ? 0 : 1;
      } else {
        shoulderDynamicMetric["completion"] = counter % 2 == 0
            ? ((shoulderAngle - 90) / (165 - 90))
            : 1 - ((shoulderAngle - 90) / (165 - 90));
      }
      shoulderDynamicMetric["confidence"] = (hip["score"] > scoreThreshold && shoulder["score"] > scoreThreshold && elbow["score"] > scoreThreshold);
      shoulderDynamicMetric["message"] = counter % 2 == 0 ? "Please raise your " + i + " arm completely" : "Please lower your " + i + " arm completely";
      keyPointList.add(shoulderDynamicMetric);
    }

    var flag = true;
    keyPointList.forEach((metric) {
      if (metric["completion"] != 1) {
        flag = false;
      }
    });
    result["isStepCompleted"] = flag;

    var partsToDisplay = [
      [keyPoints.leftShoulder, keyPoints.leftElbow],
      [keyPoints.leftElbow, keyPoints.leftWrist],
      [keyPoints.rightShoulder, keyPoints.rightElbow],
      [keyPoints.rightElbow, keyPoints.rightWrist],
      [keyPoints.leftShoulder, keyPoints.rightShoulder],
    ];
    result["partsToDisplay"] = partsToDisplay;

    result["keypoints"] = keyPointList;
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
    const scoreThreshold = 0.5;

    var shoulder,elbow,wrist,hip,knee;
    if(keyPoints.rightWrist["score"]+keyPoints.rightElbow["score"]+keyPoints.rightShoulder["score"] >
        keyPoints.leftWrist["score"]+keyPoints.leftElbow["score"]+keyPoints.leftShoulder["score"]) {
      shoulder = keyPoints.rightShoulder;
      wrist = keyPoints.rightWrist;
      elbow = keyPoints.rightElbow;
      hip = keyPoints.rightHip;
      knee = keyPoints.rightKnee;
    } else {
      shoulder = keyPoints.leftShoulder;
      wrist = keyPoints.leftWrist;
      elbow = keyPoints.leftElbow;
      hip = keyPoints.leftHip;
      knee = keyPoints.leftKnee;
    }

    var backAngle = skeleton.getAngleBetween(shoulder, hip, knee);
    var backMetric = Map<String, dynamic>();
    backMetric["x"] = hip["x"];
    backMetric["y"] = hip["y"];
    backMetric["type"] = metricType.static;
    backMetric["completion"] = (backAngle > 170) ? 1 : 0;
    backMetric["confidence"] = (shoulder["score"] > scoreThreshold && hip["score"] > scoreThreshold && knee["score"] > scoreThreshold);
    backMetric["message"] = "correct back"; //TODO: message
    keyPointList.add(backMetric);

    var elbowAngle = skeleton.getAngleBetween(shoulder, elbow, wrist);
    var elbowMetric = Map<String, dynamic>();
    elbowMetric["x"] = elbow["x"];
    elbowMetric["y"] = elbow["y"];
    elbowMetric["type"] = metricType.static;
    elbowMetric["completion"] = elbowAngle > 150 ? 1 : 0;
    elbowMetric["confidence"] = (shoulder["score"] > scoreThreshold && elbow["score"] > scoreThreshold && wrist["score"] > scoreThreshold);
    elbowMetric["message"] = "correct elbow"; //TODO: message
    keyPointList.add(elbowMetric);

    var shoulderAngle = skeleton.getAngleBetween(wrist, shoulder, hip);
    var shoulderMetric = Map<String, dynamic>();
    shoulderMetric["x"] = shoulder["x"];
    shoulderMetric["y"] = shoulder["y"];
    shoulderMetric["type"] = metricType.dynamic;
    if (shoulderAngle > 80.0) {
      shoulderMetric["completion"] = counter % 2 == 0 ? 1 : 0;
    } else if (shoulderAngle < 20.0) {
      shoulderMetric["completion"] = counter % 2 == 0 ? 0 : 1;
    } else {
      shoulderMetric["completion"] = counter % 2 == 0
          ? ((shoulderAngle - 20) / (80 - 20))
          : 1 - ((shoulderAngle - 20) / (80 - 20));
    }
    shoulderMetric["confidence"] = (shoulder["score"] > scoreThreshold && wrist["score"] > scoreThreshold && hip["score"] > scoreThreshold);
    shoulderMetric["message"] = "correct shoulder"; //TODO: message
    keyPointList.add(shoulderMetric);

    var flag = true;
    keyPointList.forEach((metric) {
      if (metric["completion"] != 1) {
        flag = false;
      }
    });

    var partsToDisplay = [
      [shoulder, elbow],
      [elbow, wrist],
      [shoulder, hip],
    ];
    result["partsToDisplay"] = partsToDisplay;

    result["isStepCompleted"] = flag;
    result["keypoints"] = keyPointList;
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
