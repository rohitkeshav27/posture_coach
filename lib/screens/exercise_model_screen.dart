import 'dart:math';
import 'package:flutter/material.dart';
import 'package:posture_coach/cameras.dart';
import 'package:posture_coach/bndbox.dart';
import 'package:posture_coach/stickFigure.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          widget.exerciseName,
          style: TextStyle(color: Colors.black),
        )),
      ),
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
    });
  }

  Future loadModel() async {
    Tflite?.close();
    return await Tflite.loadModel(
      model: "assets/models/posenet_mv1_075_float_from_checkpoints.tflite",
    );
  }
}