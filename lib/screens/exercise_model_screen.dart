import 'dart:math';
import 'package:flutter/material.dart';
import 'package:posture_coach/cameras.dart';
import 'package:posture_coach/bndbox.dart';
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
        var pose = new Skeleton(recognitions);
        //.display();
      }
    });
  }

  Future loadModel() async {
    return await Tflite.loadModel(
      model: "assets/models/posenet_mv1_075_float_from_checkpoints.tflite",
      // model: "assets/models/posenet_mobilenet_v1_100_257x257_multi_kpt_stripped.tflite",
      // model: "assets/models/multi_person_mobilenet_v1_075_float.tflite",
      useGpuDelegate: true,
      numThreads: 2,
    );
  }
}
