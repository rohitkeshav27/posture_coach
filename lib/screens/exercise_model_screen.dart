import 'dart:async';
import 'package:posture_coach/Custom_Widgets/timerScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posture_coach/cameras.dart';
import 'package:posture_coach/metrics.dart';
import 'package:posture_coach/poses.dart';
import 'package:posture_coach/stickFigure.dart';
import 'package:camera/camera.dart';
import 'package:posture_coach/keypointConstants.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'dart:math';

enum MetricStatus {
  start,
  inProgress,
  completed,
  notCompleted,
}

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
  Size screen;
  double cameraHeight = 0.0;
  double cameraWidth = 0.0;
  String angle = "";
  var completions;
  int counter = 0;
  bool metricFlag = true;
  var dynamicMetricStatus = Map();
  var messages = Map();
  bool showFeedback = false;
  final String tickImageString = 'images/tick.png';
  final String crossImageString = 'images/cross.png';
  var feedbackImageToDisplay = '';
  bool timerCompleted = false;
  var timerWidget;
  VoiceController _voiceController;
  bool alreadyCalled = true;
  var messagesGood = [
    "Good Work",
    "Excellent",
    "You're Doing Great",
    "Amazing",
    "Wonderful",
    "Well Done",
    "No Pain No Gain",
    "Just do it",
    "Keep Pushing"
  ];

  @override
  void initState() {
    _voiceController = FlutterTextToSpeech.instance.voiceController();
    _voiceController.init().then((_) {
      timerWidget = TimerScreen();
      timerWidget.voiceController = _voiceController;
    });
    super.initState();
    var res = loadModel();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    super.dispose();
    _voiceController.stop();
  }

  _playVoice(text) {
    _voiceController.speak(
      text,
      VoiceControllerOptions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        CameraScreen(
          cameras: widget.cameras,
          setRecognitions: _setRecognitions,
          getCameraScale: _getCameraScale,
        ),
        timerCompleted
            ? Stack(children: [
                // BndBox(
                //   results: _recognitions == null ? [] : _recognitions,
                //   height: cameraHeight,
                //   width: cameraWidth,
                // ),
                CustomPaint(
                    painter: MyPainter(
                  height: cameraHeight,
                  width: cameraWidth,
                  partsToDisplay:
                      completions == null ? [] : completions["partsToDisplay"],
                )),
                Positioned(
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                        )),
                    child: Text(
                      // counter.toString() + " " + metricFlag.toString(),
                      "Reps: " + (counter ~/ 2).toString(),
                      style: TextStyle(
                        color: Color.fromRGBO(37, 213, 253, 1.0),
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
                JointCompletion(
                  results: completions == null
                      ? Map<dynamic, dynamic>()
                      : completions,
                  height: cameraHeight,
                  width: cameraWidth,
                ),
                Positioned(
                  // top: cameraHeight + 8,
                  bottom: 8,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      messages.values.join("\n"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 10,
                    right: 20,
                    child: Opacity(
                      opacity: showFeedback ? 1 : 0,
                      child: Image(
                        image: AssetImage(feedbackImageToDisplay),
                        height: 50,
                        width: 50,
                      ),
                    )),
                completions == null || _recognitions.isEmpty ? Stack(
                  children: [Container(
                    color: Colors.black.withOpacity(0.5),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  Positioned(
                    top: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                          "You are not completely visible. Please step into the camera's field of view.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                        ),
                      )
                    ),
                  )],
                ) : Container()
              ])
            : Stack(
                children: [
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  timerWidget != null ? timerWidget : Container()
                ],
              ),
      ]),
    );
  }

  _setRecognitions(recognitions, imageHeight, imageWidth) {
    if (!mounted) {
      return;
    }
    setState(() {
      _recognitions = recognitions;
      if (_recognitions.isNotEmpty) {
        timerCompleted = timerWidget.getIsTimerCompleted();

        keyPoints = new KeyPointConstants(_recognitions);
      }

      if (_recognitions.isNotEmpty && timerCompleted) {
        var pose = PosesFactory.getPose(widget.exerciseName);
        completions =
            pose.evaluate(keyPoints, imageHeight, imageWidth, counter);
        if (completions != null) {
          alreadyCalled = true;
          managePose();

          if (completions["isStepCompleted"] && metricFlag) {
            dynamicMetricStatus.clear();
            messages.clear();
            displayTickForDuration(2);
            counter++;
          }
        }
      }

      if(timerCompleted && alreadyCalled && (completions == null || _recognitions.isEmpty)) {
        _playVoice("You are not completely visible.");
        alreadyCalled = false;
      }
    });
  }

  T getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  void displayTickForDuration(int seconds) {
    feedbackImageToDisplay = tickImageString;
    if (Random().nextBool() && counter % 2 == 0) {
      var element = getRandomElement(messagesGood);
      _playVoice(element);
    }
    showFeedback = true;
    Timer(Duration(seconds: seconds), () {
      showFeedback = false;
    });
  }

  void managePose() {
    bool reset = true;
    completions["keypoints"].asMap().forEach((index, metric) {
      if (metric.containsKey("confidence")) if (metric["confidence"]) {
        if (metric["type"] == metricType.static && metric["completion"] == 0) {
          metricFlag = false;
          if (!messages.containsKey(index)) {
            _playVoice(metric["message"]);
          }
          messages[index] = metric["message"];
          feedbackImageToDisplay = crossImageString;
          showFeedback = true;
        }
        if (metric["type"] == metricType.static && metric["completion"] == 0) {
          reset = false;
        }
        if (metric["type"] == metricType.dynamic && metric["completion"] != 0) {
          reset = false;
        }
        if (metric["type"] == metricType.dynamic) {
          if (!dynamicMetricStatus.containsKey(index)) {
            dynamicMetricStatus[index] = MetricStatus.start;
          } else {
            if (dynamicMetricStatus[index] == MetricStatus.start &&
                metric["completion"] > 0.2) {
              dynamicMetricStatus[index] = MetricStatus.inProgress;
            }
            if (dynamicMetricStatus[index] == MetricStatus.inProgress &&
                metric["completion"] == 1) {
              dynamicMetricStatus[index] = MetricStatus.completed;
              messages.remove(index);
            }
            if (dynamicMetricStatus[index] == MetricStatus.inProgress &&
                metric["completion"] == 0) {
              dynamicMetricStatus[index] = MetricStatus.notCompleted;
              messages[index] = metric["message"];
              _playVoice(messages[index]);
              feedbackImageToDisplay = crossImageString;
              showFeedback = true;
            }
            if (dynamicMetricStatus[index] == MetricStatus.notCompleted &&
                metric["completion"] > 0.2) {
              dynamicMetricStatus[index] = MetricStatus.inProgress;
            }
            if (dynamicMetricStatus[index] == MetricStatus.completed &&
                metric["completion"] == 0) {
              dynamicMetricStatus[index] = MetricStatus.start;
            }
          }
        }
      } else {
        reset = false;
      }
    });
    if (reset && !metricFlag) {
      metricFlag = true;
      showFeedback = false;
      // completions["keypoints"].asMap().forEach((index, metric) {
      //   if (metric["type"] == metricType.static) {
      //     messages.remove(index);
      //   }
      // });
    }
  }

  _getCameraScale(imageHeight, imageWidth) {
    _imageHeight = imageHeight;
    _imageWidth = imageWidth;
    if (screen.height / screen.width < _imageHeight / _imageWidth) {
      cameraWidth = screen.height / _imageHeight * _imageWidth;
      cameraHeight = screen.height;
    } else {
      cameraHeight = screen.width / _imageWidth * _imageHeight;
      cameraWidth = screen.width;
    }
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
