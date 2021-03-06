import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

typedef void RecognitionCallback(List<dynamic> list, int h, int w);
typedef void ScaleCallback(int h, int w);

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final RecognitionCallback setRecognitions;
  final ScaleCallback getCameraScale;

  const CameraScreen({this.cameras, this.setRecognitions, this.getCameraScale});

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
  int cameraHeight = 0;
  int cameraWidth = 0;

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
            //log(recognitions.toString())
            if (cameraHeight == 0 || cameraWidth == 0) {
              cameraHeight = math.max(img.height, img.width);
              cameraWidth = math.min(img.height, img.width);
              widget.getCameraScale(cameraHeight, cameraWidth);
            }
            widget.setRecognitions(recognitions, img.height, img.width);
            isDetecting = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
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

    return Positioned(
      top: 0,
      height:
          screenRatio < previewRatio ? screenH : screenW / previewW * previewH,
      width:
          screenRatio < previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller),
    );
  }
}
