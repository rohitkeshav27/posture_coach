import 'package:flutter/material.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';

class TimerScreen extends StatefulWidget {
  bool _isTimerCompleted = false;
  VoiceController voiceController;

  bool getIsTimerCompleted() {
    return _isTimerCompleted;
  }

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {

  _playVoice(text) {
    widget.voiceController.speak(
      text,
      VoiceControllerOptions(),
    );
    // _voiceController.stop();
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
            onUpdated: (unit, remainingTime) => _playVoice(remainingTime.toString()),
            strokeWidth: 10.0,
            countdownCurrentColor: Colors.black.withOpacity(0),
            countdownTotalColor: Colors.black.withOpacity(0),
            countdownRemainingColor: Colors.black.withOpacity(0),
            onFinished: () {
              _playVoice("Lets begin!");
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
