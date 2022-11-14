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
  bool isPlayerCommandsShowed = false;
  bool isVideoPlaying = true;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      // 'https://nan.ci/ressources/videos/demo.mp4',
      'https://assets.mixkit.co/videos/preview/mixkit-group-of-friends-partying-happily-4640-large.mp4',
      // 'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4',
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..play();

    /* _controller.addListener(() {
      setState(() {
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      });
    }); */
    // _controller.setLooping(true);
    _controller.initialize();

    showPlayerCommands();
  }

  void showPlayerCommands() {
    if (isPlayerCommandsShowed == false) {
      setState(() {
        isPlayerCommandsShowed = true;
      });

      Timer(const Duration(seconds: 5), () {
        setState(() {
          isPlayerCommandsShowed = false;
        });
      });
    }
  }

  void pauseOrResume() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() {
        isVideoPlaying = false;
      });
    } else {
      _controller.play();
      setState(() {
        isVideoPlaying = true;
      });
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
    return _controller.value.isInitialized
        ? Center(
            child: GestureDetector(
              onTap: () {
                if (isPlayerCommandsShowed) {
                  pauseOrResume();
                }
                showPlayerCommands();
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
                              child: VideoProgressIndicator(
                                _controller,
                                allowScrubbing: true,
                                colors: const VideoProgressColors(
                                    playedColor: AppColors.mainViolet),
                              )),
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
                                    onTap: () async {
                                      // ;
                                      // print(MediaQuery.of(context).orientation);
                                      MediaQuery.of(context).orientation ==
                                              Orientation.portrait
                                          ? {
                                              await SystemChrome
                                                  .setEnabledSystemUIMode(
                                                      SystemUiMode.manual,
                                                      overlays: []),
                                              await SystemChrome
                                                  .setPreferredOrientations([
                                                DeviceOrientation.landscapeLeft,
                                                DeviceOrientation
                                                    .landscapeRight,
                                              ])
                                            }
                                          : {
                                              await SystemChrome
                                                  .setEnabledSystemUIMode(
                                                      SystemUiMode.edgeToEdge),
                                              await SystemChrome
                                                  .setPreferredOrientations([
                                                DeviceOrientation.portraitUp,
                                              ])
                                            };
                                    },
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
}
