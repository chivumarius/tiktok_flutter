import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  // ♦ Property:
  final String videoUrl;

  // ♦ Constructor:
  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  // ♦ Controller:
  late VideoPlayerController videoPlayerController;

  // ♦ The "initState()" Method:
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        // ♦ Playing Video
        videoPlayerController.play();

        // ♦ Set the Volune:
        videoPlayerController.setVolume(1);
      });
  }

  // ♦ The "dispose()" Method:
  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  // ♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    // ♦ Variable:
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(videoPlayerController),
    );
  }
}
