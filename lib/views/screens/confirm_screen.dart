import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/controllers/upload_video_controller.dart';
import 'package:tiktok_flutter/views/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  // ♦ Properties:
  final File videoFile;
  final String videoPath;

  // ♦ Constructor:
  const ConfirmScreen({
    Key? key,
    required this.videoFile,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  // ♦ Controllers:
  late VideoPlayerController controller;
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  // ♦ Initializing the Controller:
  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  // ♦ The "initState()" Method:
  @override
  void initState() {
    super.initState();

    // ♦ Set the Controller:
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });

    // ♦ Initialization the Controller:
    controller.initialize();

    // ♦ Play of the Controller:
    controller.play();

    // ♦ Setting the Controller Volume:
    controller.setVolume(1);

    // ♦ Setting the Controller Looping:
    controller.setLooping(true);
  }

  // ♦ The "dispose()" Method:
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  // ♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ♦ Spacing:
            const SizedBox(
              height: 30,
            ),

            // ♦
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(controller),
            ),

            // ♦ Spacing:
            const SizedBox(
              height: 30,
            ),

            // ♦ Scroll View:
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ♦ Song Name → "Text Input Field":
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _songController,
                      labelText: 'Song Name',
                      icon: Icons.music_note,
                    ),
                  ),

                  // ♦ Spacing:
                  const SizedBox(
                    height: 10,
                  ),

                  // ♦ Caption → "Text Input Field":
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _captionController,
                      labelText: 'Caption',
                      icon: Icons.closed_caption,
                    ),
                  ),

                  // ♦ Spacing:
                  const SizedBox(
                    height: 10,
                  ),

                  // ♦ "Share" Button:
                  ElevatedButton(
                      onPressed: () => uploadVideoController.uploadVideo(
                            _songController.text,
                            _captionController.text,
                            widget.videoPath,
                          ),
                      child: const Text(
                        'Share!',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
