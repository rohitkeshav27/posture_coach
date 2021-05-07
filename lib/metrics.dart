import 'package:posture_coach/poses.dart';
import 'package:posture_coach/skeleton.dart';

/*
    {
    isStepCompleted: Bool,
    keypoints: [ { "x":double, "y":double, "completion":double(range 0-1), "type":double(static:0, dynamic:1)} , {} ]
    }
*/

class BicepCurl implements Poses {
  Map<dynamic,dynamic> evaluate(var recognitions, var imageHeight, var imageWidth, var counter) {
    print("Bicep curl evaluate");
    var result = Map<String,dynamic>();
    var keypointList = [];
    var skeleton = new Skeleton(recognitions, imageHeight, imageWidth);


    var elbowAngle = skeleton.getAngleBetween(recognitions[0]["keypoints"][6], recognitions[0]["keypoints"][8],
        recognitions[0]["keypoints"][10]);
    var elbowMetric = Map<String,double>();
    elbowMetric["x"] = recognitions[0]["keypoints"][8]["x"];
    elbowMetric["y"] = recognitions[0]["keypoints"][8]["y"];
    elbowMetric["type"] = 1;
    if (elbowAngle < 40.0) {
      elbowMetric["completion"] = counter % 2 == 0 ? 1 : 0;
    }
    else if (elbowAngle > 165.0) {
      elbowMetric["completion"] = counter % 2 == 0 ? 0 : 1;
    }
    else {
      elbowMetric["completion"] = counter % 2 == 0 ? 1 - ((elbowAngle - 40) / (165 - 40)) : ((elbowAngle - 40) / (165 - 40));
    }
    keypointList.add(elbowMetric);

    var shoulderAngle = skeleton.getAngleBetween(recognitions[0]["keypoints"][12], recognitions[0]["keypoints"][6],
        recognitions[0]["keypoints"][8]);
    var shoulderMetric = Map<String,double>();
    shoulderMetric["x"] = recognitions[0]["keypoints"][6]["x"];
    shoulderMetric["y"] = recognitions[0]["keypoints"][6]["y"];
    shoulderMetric["type"] = 0;
    shoulderMetric["completion"] = shoulderAngle < 35.0 ? 1 : 0;
    keypointList.add(shoulderMetric);

    var flag = true;
    keypointList.forEach((metric) {
      if(metric["completion"] != 1) {
        flag = false;
      }
    });
    result["isStepCompleted"] = flag;
    result["keypoints"] = keypointList;
    return result;
  }
}

class ShoulderPress implements Poses {
  Map<dynamic,dynamic> evaluate(var recognitions, var imageHeight, var imageWidth, var counter) {
    print("Shoulder Press evaluate");
    var result = Map<String,dynamic>();
    var keypointList = [];
    var skeleton = new Skeleton(recognitions, imageHeight, imageWidth);

    return result;
  }
}

class ShoulderFrontRaise implements Poses {
  Map<dynamic,dynamic> evaluate(var recognitions, var imageHeight, var imageWidth, var counter) {
    print("Shoulder Press evaluate");
    var result = Map<String,dynamic>();
    var keypointList = [];
    var skeleton = new Skeleton(recognitions, imageHeight, imageWidth);

    return result;
  }
}

class Shrugs implements Poses {
  Map<dynamic,dynamic> evaluate(var recognitions, var imageHeight, var imageWidth, var counter) {
    print("Shoulder Press evaluate");
    var result = Map<String,dynamic>();
    var keypointList = [];
    var skeleton = new Skeleton(recognitions, imageHeight, imageWidth);

    return result;
  }
}