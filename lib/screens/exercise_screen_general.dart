import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:posture_coach/Custom_Widgets/flipping_card.dart';
import 'package:posture_coach/Custom_Widgets/on_screen_button.dart';

class ExerciseScreenGeneral extends StatefulWidget {
  final String videoName;
  final double paddingValue;
  final String exerciseName;
  final String cardFrontInfo;
  final String cardBackInfo;
  final String routeGrindNow;

  ExerciseScreenGeneral(
      {this.videoName,
      this.paddingValue,
      this.exerciseName,
      this.cardFrontInfo,
      this.cardBackInfo,
      this.routeGrindNow})
      : super();

  @override
  ExerciseScreenGeneralState createState() => ExerciseScreenGeneralState();
}

class ExerciseScreenGeneralState extends State<ExerciseScreenGeneral> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.videoName);
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
        title: Padding(
            padding: EdgeInsets.only(left: widget.paddingValue),
            child: Text(
              widget.exerciseName,
              style: TextStyle(color: Colors.red),
            )),
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
            front_info: widget.cardFrontInfo,
            back_info: widget.cardBackInfo,
          ),
          SizedBox(
            height: 30.0,
          ),
          ButtonOnScreen(
            routeto: widget.routeGrindNow,
          )
        ],
      ),
    );
  }
}
