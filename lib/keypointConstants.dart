class KeyPointConstants {
  var leftWrist;
  var leftElbow;
  var leftShoulder;
  var leftHip;
  var leftKnee;
  var leftAnkle;
  var leftEye;
  var leftEar;
  var nose;
  var rightWrist;
  var rightElbow;
  var rightShoulder;
  var rightHip;
  var rightKnee;
  var rightAnkle;
  var rightEye;
  var rightEar;

  KeyPointConstants(recognitions) {
    print (recognitions);
    leftWrist = recognitions[0]["keypoints"][9];
    leftElbow = recognitions[0]["keypoints"][7];
    leftShoulder = recognitions[0]["keypoints"][5];
    leftHip = recognitions[0]["keypoints"][11];
    leftKnee = recognitions[0]["keypoints"][13];
    leftAnkle = recognitions[0]["keypoints"][15];
    leftEye = recognitions[0]["keypoints"][1];
    leftEar = recognitions[0]["keypoints"][3];
    nose = recognitions[0]["keypoints"][0];
    rightWrist = recognitions[0]["keypoints"][10];
    rightElbow = recognitions[0]["keypoints"][8];
    rightShoulder = recognitions[0]["keypoints"][6];
    rightHip = recognitions[0]["keypoints"][12];
    rightKnee = recognitions[0]["keypoints"][14];
    rightAnkle = recognitions[0]["keypoints"][16];
    rightEye = recognitions[0]["keypoints"][2];
    rightEar = recognitions[0]["keypoints"][4];
  }
}
