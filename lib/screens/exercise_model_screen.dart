import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posture_coach/cameras.dart';
import 'package:posture_coach/bndbox.dart';
import 'package:posture_coach/poses.dart';
import 'package:posture_coach/stickFigure.dart';
import 'package:camera/camera.dart';
import 'package:posture_coach/skeleton.dart';
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
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String angle = "";
  var completions;
  int counter = 0;

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
          previewW: min(_imageHeight, _imageWidth),
          screenH: screen.height,
          screenW: screen.width,
        ),
        CustomPaint(
            painter: MyPainter(
            results: _recognitions == null ? [] : _recognitions,
          previewH: max(_imageHeight, _imageWidth),
          previewW: min(_imageHeight, _imageWidth),
          screenH: screen.height,
          screenW: screen.width,
            )
        ),
        Positioned(
          top: 10,
          child: Text(
          counter.toString(),
          style: TextStyle(
            color: Color.fromRGBO(37, 213, 253, 1.0),
            fontSize: 20.0,
          ),
        )
        ),
        JointCompletion(
          results: completions == null ? Map<dynamic,dynamic>() : completions,
          previewH: max(_imageHeight, _imageWidth),
          previewW: min(_imageHeight, _imageWidth),
          screenH: screen.height,
          screenW: screen.width,
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
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
      if(_recognitions.isNotEmpty) {
        // var skeleton = new Skeleton(recognitions, imageHeight, imageWidth);
        // if (recognitions[0]["keypoints"][8]["score"]>0.5) {
        //   angle = skeleton.getAngleBetween(
        //       recognitions[0]["keypoints"][6], recognitions[0]["keypoints"][8],
        //       recognitions[0]["keypoints"][10]).toString();
        //   print("angle: "+angle);
        // }
        //.display();
        var pose = PosesFactory.getPose(widget.exerciseName);
        completions = pose.evaluate(recognitions, imageHeight, imageWidth, counter);
        if (completions["isStepCompleted"]) {
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
