import 'package:posture_coach/keypointConstants.dart';
import 'package:posture_coach/poses.dart';
import 'package:posture_coach/skeleton.dart';

/*
    {
    isStepCompleted: Bool,
    keypoints: [ { "x":double, "y":double, "completion":double(range 0-1), "type":metricType} , {} ]
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

    var elbowAngle = skeleton.getAngleBetween(
        keyPoints.rightShoulder, keyPoints.rightElbow, keyPoints.rightWrist);
    var elbowMetric = Map<String, dynamic>();
    elbowMetric["x"] = keyPoints.rightElbow["x"];
    elbowMetric["y"] = keyPoints.rightElbow["y"];
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
    keyPointList.add(elbowMetric);

    var shoulderAngle = skeleton.getAngleBetween(
        keyPoints.rightHip, keyPoints.rightShoulder, keyPoints.rightElbow);
    var shoulderMetric = Map<String, dynamic>();
    shoulderMetric["x"] = keyPoints.rightShoulder["x"];
    shoulderMetric["y"] = keyPoints.rightShoulder["y"];
    shoulderMetric["type"] = metricType.static;
    shoulderMetric["completion"] = shoulderAngle < 35.0 ? 1 : 0;
    keyPointList.add(shoulderMetric);

    var flag = true;
    keyPointList.forEach((metric) {
      if (metric["completion"] != 1) {
        flag = false;
      }
    });
    result["isStepCompleted"] = flag;
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

class Shrugs implements Poses {
  Map<dynamic, dynamic> evaluate(
      KeyPointConstants keyPoints, var imageHeight, var imageWidth, var counter) {
    print("Shoulder Press evaluate");
    var result = Map<String, dynamic>();
    var keyPointList = [];
    var skeleton = new Skeleton(keyPoints, imageHeight, imageWidth);

    return result;
  }
}
