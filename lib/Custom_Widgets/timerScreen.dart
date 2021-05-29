import 'package:flutter/material.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';

class TimerScreen extends StatefulWidget {
  bool _isTimerCompleted = false;

  bool getIsTimerCompleted() {
    return _isTimerCompleted;
  }

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  VoiceController _voiceController;

  @override
  void initState() {
    super.initState();
    _voiceController = FlutterTextToSpeech.instance.voiceController();
    _voiceController.init();
  }

  @override
  void dispose() {
    super.dispose();
    _voiceController.stop();
  }

  playVoice(text) {
    _voiceController.speak(
      text,
      VoiceControllerOptions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Exercise Starts in ...",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        Center(
          child: TimeCircularCountdown(
            unit: CountdownUnit.second,
            countdownTotal: 5,
            onUpdated: (unit, remainingTime) => playVoice(remainingTime),
            strokeWidth: 10.0,
            countdownCurrentColor: Colors.black.withOpacity(0),
            countdownTotalColor: Colors.black.withOpacity(0),
            countdownRemainingColor: Colors.black.withOpacity(0),
            onFinished: () {
              setState(() {
                widget._isTimerCompleted = true;
              });
            },
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
