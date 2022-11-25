import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nan_class/ui/colors/app_colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  bool isPlayerCommandsShowed = true;
  bool isVideoPlaying = false;
  //The video current time to show
  String videoPlayingTime = "";
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      // 'https://nan.ci/ressources/videos/demo.mp4',
      // 'https://assets.mixkit.co/videos/preview/mixkit-group-of-friends-partying-happily-4640-large.mp4',
      'https://classe.nan.ci/mobmed/video/FLUTTER/EN->4-build-foodpanda-uber-eats-clone-app-with-admin-web-portal_Oct_Nov/01_+-_+Introduction/001_+Introduction.mp4',
      // 'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4',
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      // print(_controller.value.duration.inSeconds);
      setState(() {
        //Update the video current time
        videoPlayingTime = videoTime(_controller.value.position.inSeconds);
      });
    });
    
    _controller.initialize();
  }

  void showPlayerCommands() {
    if (isPlayerCommandsShowed == false) {
      setState(() {
        isPlayerCommandsShowed = true;
      });
    }

    Timer(const Duration(seconds: 5), () {
      setState(() {
        isPlayerCommandsShowed = false;
      });
    });
  }

  void pauseOrResume() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() {
        isVideoPlaying = false;
        isPlayerCommandsShowed = true;
      });
    } else {
      _controller.play();
      setState(() {
        isVideoPlaying = true;
      });
      showPlayerCommands();
    }
  }

  bool isPlaying() {
    return _controller.value.isPlaying;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    //  print(_controller.);
    return _controller.value.isInitialized
        ? Center(
            child: GestureDetector(
              onTap: () {
                if (isPlayerCommandsShowed) {
                  pauseOrResume();
                }
                else {
                  setState(() {
                    isPlayerCommandsShowed = true;
                  });
                }
              },
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        height: _controller.value.size.height,
                        width: _controller.value.size.width,
                        child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller)),
                      ),
                    ),

                    //!controller
                    if (isPlayerCommandsShowed)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    VideoTimeWidget(
                                        videoPlayingTime: videoPlayingTime),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: VideoProgressIndicator(
                                        _controller,
                                        allowScrubbing: true,
                                        padding: const EdgeInsets.all(0),
                                        colors: const VideoProgressColors(
                                            playedColor: AppColors.mainViolet),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    VideoTimeWidget(
                                        videoPlayingTime: videoTime(_controller
                                            .value.duration.inSeconds)),
                                  ])),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Icon(
                                    isPlaying()
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                    shadows: const [
                                      Shadow(color: Colors.black, blurRadius: 5)
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  height: 0,
                                )),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: setLandscapeOrPortrait,
                                    child: const Icon(
                                      Icons.fullscreen,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black, blurRadius: 5)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  void setLandscapeOrPortrait() async {
    MediaQuery.of(context).orientation == Orientation.portrait
        ? {
            await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                overlays: []),
            await SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ])
          }
        : {
            await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
            await SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ])
          };
  }
}

class VideoTimeWidget extends StatelessWidget {
  const VideoTimeWidget({
    Key? key,
    required this.videoPlayingTime,
  }) : super(key: key);

  final String videoPlayingTime;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Text(
          videoPlayingTime,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 15,
                )
              ]),
        ));
  }
}

///Takes time in second and return a custom formated string to be display
///
///videoTime(69) will return "01:09"
String videoTime(int time) {
  int min = ((time >= 60) ? time / ~60 : 0).toInt();
  int seconds = time % 60;
  String secondsString = seconds <= 9 ? "0$seconds" : "$seconds";
  String minString = min <= 9 ? "0$min" : "$min";
  return "$minString : $secondsString";
}
