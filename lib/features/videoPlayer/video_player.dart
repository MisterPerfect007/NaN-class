import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nan_class/ui/colors/app_colors.dart';
import 'package:video_player/video_player.dart';

import '../../core/utils/utils.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoLink;
  const VideoPlayerPage({super.key, 
  required this.videoLink
  });

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
    // print(widget.videoLink);
    _controller = VideoPlayerController.network(
      'https://' + widget.videoLink,
      // widget.videoLink,
      // 'https://classe.nan.ci/mobmed/videomob/FLUTTER/FR-%3Ematrisier_flutter_Oct_Nov/1-section_+one/Easy_+Nest.js_+Authentication_+With_+Passport.js_+__+(GraphQL_++_+Rest_+API).mp4',
      // 'https://assets.mixkit.co/videos/preview/mixkit-group-of-friends-partying-happily-4640-large.mp4',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      // print(_controller.value.duration.inSeconds);
      setState(() {
        //Update the video current time
        videoPlayingTime = formatTimeMMSS(_controller.value.position.inSeconds);
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
     print(" >>>>>>>>>>>>>>>>>>>>>>> ${_controller.value.errorDescription}");
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
                                        videoPlayingTime: formatTimeMMSS(_controller
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
