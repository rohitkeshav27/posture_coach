import 'dart:math';

class Skeleton {
  Map<String,double> bodyPart;

  Skeleton(List<dynamic> recognitions) {
    bodyPart = new Map();
    getLengths(recognitions);
    normalize(recognitions);
  }

  void getLengths(List<dynamic> recognitions) {
    bodyPart["shoulderLength"] = straightLineDistance(recognitions[0]["keypoints"][5], recognitions[0]["keypoints"][6]);
    bodyPart["hipLength"] = straightLineDistance(recognitions[0]["keypoints"][11], recognitions[0]["keypoints"][12]);
    bodyPart["rightTorsoLength"] = straightLineDistance(recognitions[0]["keypoints"][6], recognitions[0]["keypoints"][12]);
    bodyPart["leftTorsoLength"] = straightLineDistance(recognitions[0]["keypoints"][5], recognitions[0]["keypoints"][11]);
  }

  void normalize(List<dynamic> recognitions) {
    var normalizationConstant = (bodyPart["rightTorsoLength"] + bodyPart["leftTorsoLength"])/2;
    // var normalizationConstant = straightLineDistance(midPoint(recognitions[0]["keypoints"][5], recognitions[0]["keypoints"][6]), midPoint(recognitions[0]["keypoints"][11], recognitions[0]["keypoints"][12]));
    bodyPart.forEach((key, value) {
      bodyPart.update(key, (value) => value/normalizationConstant);
    });
    // print("left shoulder "+recognitions[0]["keypoints"][5]["x"].toString()+" "+recognitions[0]["keypoints"][5]["y"].toString());
    // print("right shoulder "+recognitions[0]["keypoints"][6]["x"].toString()+" "+recognitions[0]["keypoints"][6]["y"].toString());
    // print("left hip "+recognitions[0]["keypoints"][11]["x"].toString()+" "+recognitions[0]["keypoints"][11]["y"].toString());
    // print("right hip "+recognitions[0]["keypoints"][12]["x"].toString()+" "+recognitions[0]["keypoints"][12]["y"].toString());
    // print("constant = "+normalizationConstant.toString());
  }

  // Geometric functions

  double straightLineDistance(var p1, var p2) {
    return sqrt(pow((p1["x"]-p2["x"]),2) + pow((p1["y"]-p2["y"]),2));
  }

  Map<String,double> midPoint(var p1, var p2) {
    return {"x":(p1["x"]+p2["x"])/2,"y":(p1["y"]+p2["y"])/2};
  }

  void display() {
    bodyPart.forEach((key, value) {
      print(key+"\t"+value.toString());
    });
  }
}