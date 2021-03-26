import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posture_coach/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:posture_coach/Custom_Widgets/flipping_card.dart';
import 'package:posture_coach/Custom_Widgets/buttononscreen.dart';

class ShrugScreen extends StatefulWidget {
  ShrugScreen() : super();
  @override
  ShrugScreenState createState() => ShrugScreenState();
}

class ShrugScreenState extends State<ShrugScreen> {
  //
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset("videos/Shrug.mp4");
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
            padding: EdgeInsets.only(left: 55.0),
            child: Text(
              "Shoulder Shrugs",
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
            front_info: kshrug_info_front,
            back_info: kshrug_info_back,
          ),
          SizedBox(
            height: 30.0,
          ),
          ButtonOnScreen(
            routeto: 'shrug/shrugmod',
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
