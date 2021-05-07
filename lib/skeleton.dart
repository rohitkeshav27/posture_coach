import 'dart:math';

class Skeleton {
  Map<String,double> bodyPart;
  int imageHeight;
  int imageWidth;
  var normalizationConstant;

  Skeleton(List<dynamic> keypoints, imageHeight, imageWidth) {
    this.imageHeight = imageHeight;
    this.imageWidth = imageWidth;
    bodyPart = new Map();
    getLengths(keypoints);
    normalize(keypoints);
  }

  void getLengths(List<dynamic> keypoints) {
    bodyPart["shoulderLength"] = straightLineDistance(keypoints.leftShoulder, keypoints.rightShoulder);
    bodyPart["hipLength"] = straightLineDistance(keypoints.leftHip, keypoints.rightHip);
    bodyPart["rightTorsoLength"] = straightLineDistance(keypoints.rightShoulder, keypoints.rightHip);
    bodyPart["leftTorsoLength"] = straightLineDistance(keypoints.leftShoulder, keypoints.leftHip);
  }

  void normalize(List<dynamic> keypoints) {
    normalizationConstant = (bodyPart["rightTorsoLength"] + bodyPart["leftTorsoLength"])/2;
    // var normalizationConstant = straightLineDistance(midPoint(recognitions[0]["keypoints"][5], recognitions[0]["keypoints"][6]), midPoint(recognitions[0]["keypoints"][11], recognitions[0]["keypoints"][12]));
    // bodyPart.forEach((key, value) {
    //   bodyPart.update(key, (value) => value/normalizationConstant);
    // });
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
  
  double getAngleBetween(var p1, var p2, var p3) {
    p1 = getActualCoordinates(p1);
    p2 = getActualCoordinates(p2);
    p3 = getActualCoordinates(p3);
    print("actual coordinates");
    print(p1["x"].toString()+","+p1["y"].toString());
    print(p2["x"].toString()+","+p2["y"].toString());
    print(p3["x"].toString()+","+p3["y"].toString());
    // arccos((P12^2 + P23^2 - P13^2) / (2 * P12 * P23))
    var p12 = straightLineDistance(p1, p2);//normalizationConstant;
    var p23 = straightLineDistance(p2, p3);//normalizationConstant;
    var p31 = straightLineDistance(p3, p1);//normalizationConstant;
    print("distances");
    print("p12 : "+p12.toString());
    print("p23 : "+p23.toString());
    print("p31 : "+p31.toString());
    return acos((pow(p12,2) + pow(p23,2) - pow(p31,2)) / (2 * p12 * p23))*(180/pi);
  }

  Map<dynamic,dynamic> getActualCoordinates(var p) {
    return {"x":p["x"]*min(imageHeight,imageWidth),"y":p["y"]*max(imageHeight,imageWidth)};
  }

}