import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posture_coach/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:posture_coach/Custom_Widgets/flipping_card.dart';
import 'package:posture_coach/Custom_Widgets/buttononscreen.dart';

class ExerciseScreenGeneral extends StatefulWidget {
  final String video_name;
  final double padding_value;
  final String exercise_name;
  final String card_front_info;
  final String card_back_info;
  final String route_grind_now;
  ExerciseScreenGeneral(
      {this.video_name,
      this.padding_value,
      this.exercise_name,
      this.card_front_info,
      this.card_back_info,
      this.route_grind_now})
      : super();

  @override
  ExerciseScreenGeneralState createState() => ExerciseScreenGeneralState();
}

class ExerciseScreenGeneralState extends State<ExerciseScreenGeneral> {
  //
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.video_name);
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
            padding: EdgeInsets.only(left: widget.padding_value),
            child: Text(
              widget.exercise_name,
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
            front_info: widget.card_front_info,
            back_info: widget.card_back_info,
          ),
          SizedBox(
            height: 30.0,
          ),
          ButtonOnScreen(
            routeto: widget.route_grind_now,
          )
        ],
      ),
    );
  }
}

// floatingActionButton: FloatingActionButton(
//   onPressed: () {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//       } else {
//         _controller.play();
//       }
//     });
//   },
//   child:
//       Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
// ),

// Text(
// 'Biceps curl is a general term for a series of strength'
// ' exercises that involve brachioradialis, '
// 'front deltoid and the main target on biceps brachii.'
// 'Includes variations using barbell, dumbbell and resistance band, etc.',
// textAlign: TextAlign.center,
// style: TextStyle(
// //fontFamily: 'Acetone',
// color: Colors.red[300],
// fontWeight: FontWeight.bold,
// fontSize: 25.0),
// ),
