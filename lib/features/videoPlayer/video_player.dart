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
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://nan.ci/ressources/videos/demo.mp4',
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..play();

    _controller.addListener(() {
      setState(() {
        // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      });
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(20),
      child: Center(
        child: GestureDetector(
          onTap: () {
            // _controller.addListener(() { })
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller)),
              ClosedCaption(text: _controller.value.caption.text),
              // _ControlsOverlay(controller: _controller),

              //!controller
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            shadows: [
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
                              print(MediaQuery.of(context).orientation);
                              MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? await SystemChrome
                                      .setPreferredOrientations([
                                      DeviceOrientation.landscapeLeft,
                                      DeviceOrientation.landscapeRight,
                                    ])
                                  : SystemChrome.setPreferredOrientations([
                                      DeviceOrientation.portraitUp,
                                    ]);
                            },
                            child: const Icon(
                              Icons.fullscreen,
                              color: Colors.white,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 5)
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
    );
  }
}
