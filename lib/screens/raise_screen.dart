import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:posture_coach/constants.dart';
import 'package:posture_coach/Custom_Widgets/flipping_card.dart';
import 'package:posture_coach/Custom_Widgets/buttononscreen.dart';

class RaiseScreen extends StatefulWidget {
  RaiseScreen() : super();

  final String title = "Video Demo";

  @override
  RaiseScreenState createState() => RaiseScreenState();
}

class RaiseScreenState extends State<RaiseScreen> {
  //
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset("videos/frontraise.mp4");
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
            padding: EdgeInsets.only(left: 40.0),
            child: Text(
              "Shoulder Front Raise",
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
            height: 50.0,
          ),
          FlippingCard(
            front_info: kraise_info_front,
            back_info: kraise_info_back,
          ),
          SizedBox(
            height: 30.0,
          ),
          ButtonOnScreen(
            routeto: 'raise/raisemod',
          )
        ],
      ),
    );
  }
}
