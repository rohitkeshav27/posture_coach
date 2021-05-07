import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posture_coach/cameras.dart';
import 'package:posture_coach/bndbox.dart';
import 'package:posture_coach/metrics.dart';
import 'package:posture_coach/poses.dart';
import 'package:posture_coach/stickFigure.dart';
import 'package:camera/camera.dart';
import 'package:posture_coach/skeleton.dart';
import 'package:posture_coach/keypointConstants.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/services.dart';

class ExerciseModelScreen extends StatefulWidget {
  final String exerciseName;
  final List<CameraDescription> cameras;

  @override
  const ExerciseModelScreen({Key key, this.exerciseName, this.cameras})
      : super(key: key);

  _ExerciseModelScreenState createState() => _ExerciseModelScreenState();
}

class _ExerciseModelScreenState extends State<ExerciseModelScreen> {
  KeyPointConstants keyPoints;
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String angle = "";
  var completions;
  int counter = 0;
  bool metricFlag = true;

  @override
  void initState() {
    super.initState();
    var res = loadModel();
    print('Model Response: ' + res.toString());
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        CameraScreen(
            cameras: widget.cameras, setRecognitions: _setRecognitions),
        BndBox(
          results: _recognitions == null ? [] : _recognitions,
          previewH: max(_imageHeight, _imageWidth),
          //TODO: make image dimensions global
          previewW: min(_imageHeight, _imageWidth),
          screenH: screen.height,
          screenW: screen.width,
        ),
        CustomPaint(
            painter: MyPainter(
          results: keyPoints == null ? [] : keyPoints,
          previewH: max(_imageHeight, _imageWidth),
          previewW: min(_imageHeight, _imageWidth),
          screenH: screen.height,
          screenW: screen.width,
        )),
        Positioned(
            top: 10,
            child: Text(
              counter.toString() + " " + metricFlag.toString(),
              style: TextStyle(
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                color: Color.fromRGBO(37, 213, 253, 1.0),
                fontSize: 20.0,
              ),
            )),
        JointCompletion(
          results: completions == null ? Map<dynamic, dynamic>() : completions,
          previewH: max(_imageHeight, _imageWidth),
          previewW: min(_imageHeight, _imageWidth),
          screenH: screen.height,
          screenW: screen.width,
        ),
        Positioned(
          top: max(_imageHeight, _imageWidth).toDouble(),
          child: Text(
            "some message", //TODO: Display relevant message
            style: TextStyle(
              backgroundColor: Colors.black,
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        )
      ]),
    );
  }

  _setRecognitions(recognitions, imageHeight, imageWidth) {
    if (!mounted) {
      return;
    }
    setState(() {
      _recognitions = recognitions;
      keyPoints = new KeyPointConstants(recognitions);
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
      if (_recognitions.isNotEmpty && keyPoints != null) {
        // var skeleton = new Skeleton(recognitions, imageHeight, imageWidth);
        // if (recognitions[0]["keypoints"][8]["score"]>0.5) {
        //   angle = skeleton.getAngleBetween(
        //       recognitions[0]["keypoints"][6], recognitions[0]["keypoints"][8],
        //       recognitions[0]["keypoints"][10]).toString();
        //   print("angle: "+angle);
        // }
        //.display();

        var pose = PosesFactory.getPose(widget.exerciseName);
        //TODO: Check if relevant keypoints are visible
        completions =
            pose.evaluate(keyPoints, imageHeight, imageWidth, counter);

        bool reset = true;
        completions["keypoints"].forEach((metric) {
          if (metric["type"] == metricType.static &&
              metric["completion"] == 0) {
            metricFlag = false;
          }
          if (metric["type"] == metricType.static &&
              metric["completion"] == 0) {
            reset = false;
          }
          if (metric["type"] == metricType.dynamic &&
              metric["completion"] != 0) {
            reset = false;
          }
        });
        if (reset) {
          metricFlag = true;
        }

        if (completions["isStepCompleted"] && metricFlag) {
          counter++;
        }
      }
    });
  }

  Future loadModel() async {
    return await Tflite.loadModel(
      model: "assets/models/posenet_mv1_075_float_from_checkpoints.tflite",
      // model: "assets/models/posenet_mobilenet_v1_100_257x257_multi_kpt_stripped.tflite",
      // model: "assets/models/multi_person_mobilenet_v1_075_float.tflite",
      useGpuDelegate: true,
      // numThreads: 2,
    );
  }
}
