import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_flutter/views/screens/confirm_screen.dart';
import 'package:tiktok_flutter/constants.dart';

class AddVideoScreen extends StatelessWidget {
  // ♦ Constructor
  const AddVideoScreen({Key? key}) : super(key: key);

  // ♦ The "pickVideo()" Method:
  pickVideo(ImageSource src, BuildContext context) async {
    // ♦ Picking the Video:
    final video = await ImagePicker().pickVideo(source: src);

    // ♦ Checking Condition:
    if (video != null) {
      // ♦ "Redirection" to the "Confirmation Screen":
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmScreen(
            videoFile: File(video.path),
            videoPath: video.path,
          ),
        ),
      );
    }
  }

  // ♦ The "showDialog()" Method:
  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        // ♦ List of Options:
        children: [
          // ♦ "Video Option" → Choose it from Gallery:
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.gallery, context),
            child: Row(
              children: const [
                Icon(Icons.image),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),

          // ♦ "Camera Option" to Create a "Video":
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.camera, context),
            child: Row(
              children: const [
                Icon(Icons.camera_alt),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Camera',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),

          // ♦ "Cancel Option":
          SimpleDialogOption(
            // ♦ Removing the Options List
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              children: const [
                Icon(Icons.cancel),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // The "build()" Method:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // ♦ The "Add Video" Button
        //   → is a "Rectangular Area" of a "Material"
        //   → that Responds to Touch:
        child: InkWell(
          onTap: () => showOptionsDialog(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(color: buttonColor),
            child: const Center(
              child: Text(
                'Add Video',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
