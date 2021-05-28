import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posture_coach/Exercises/exercise.dart';
import 'package:video_player/video_player.dart';
import 'package:posture_coach/Custom_Widgets/flipping_card.dart';
import 'package:posture_coach/Custom_Widgets/on_screen_button.dart';

class ExerciseScreen extends StatefulWidget {
  final Exercise exercise;

  ExerciseScreen({this.exercise}) : super();

  @override
  ExerciseScreenState createState() => ExerciseScreenState();
}

class ExerciseScreenState extends State<ExerciseScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.exercise.videoURL);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(0.0);
    _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.exercise.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SizedBox(
            height: 40.0,
          ),
          FlippingCard(
            frontInfo: widget.exercise.cardInfoFront,
            backInfo: widget.exercise.cardInfoBack,
          ),
          SizedBox(
            height: 30.0,
          ),
          ButtonOnScreen(
            routeTo: widget.exercise.route,
          )
        ],
      ),
    );
  }
}
