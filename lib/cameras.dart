import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

typedef void Callback(List<dynamic> list, int h, int w);

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;

  const CameraScreen({this.cameras, this.setRecognitions});

  @override
  State<StatefulWidget> createState() {
    return new CameraScreenState();
  }
}

class CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  bool isDetecting = false;
  int startTime;
  int endTime;
  //static const platform = const MethodChannel('ondeviceML');

  @override
  void initState() {
    super.initState();
    controller = new CameraController(widget.cameras[1], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});

      controller.startImageStream((CameraImage img) {
        if (!isDetecting) {
          isDetecting = true;

          startTime = DateTime.now().millisecondsSinceEpoch;
          Tflite.runPoseNetOnFrame(
            bytesList: img.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: img.height,
            imageWidth: img.width,
            numResults: 1,
            rotation: -90,
            threshold: 0.2,
            nmsRadius: 10,
          ).then((recognitions) {
            endTime = DateTime.now().millisecondsSinceEpoch;
            print("Detection took ${endTime - startTime}");
            //log(recognitions.toString());
            widget.setRecognitions(recognitions, img.height, img.width);
            isDetecting = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller),
    );
  }
}
