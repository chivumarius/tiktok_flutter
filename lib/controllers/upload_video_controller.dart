import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/constants.dart';
// import 'package:tiktok_flutter/models/video.dart';
// import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  // ♦ The "_compressVideo()" Method
  _compressVideo(String videoPath) async {
    // ♦ Using the "video_compress" Package
    //   → for "Video Compression":
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  // ♦ The "_uploadVideoToStorage()" Method:
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    // ♦ Calling "_compressVideo()" Method
    //   → to "Compress" the "Video":
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));

    // ♦ "Uploading" the "Video:"
    TaskSnapshot snap = await uploadTask;

    // ♦
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // ♦ The "_getThumbnail()" Method:
  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  // ♦ The "_uploadImageToStorage()" Method:
  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // ♦ The "uploadVideo()" Method:
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      // ♦ Getting "User ID":
      String uid = firebaseAuth.currentUser!.uid;

      // ♦ Getting All "Users":
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();

      // ♦ Get All Video ID:
      var allDocs = await firestore.collection('videos').get();

      // ♦ Getting the "Number of Documents" of the "Video Collection":
      int len = allDocs.docs.length;

      // ♦ Calling the "_uploadVideoToStorage()": Function
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);

      // ♦
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: "Video $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
        thumbnail: thumbnail,
      );

      await firestore.collection('videos').doc('Video $len').set(
            video.toJson(),
          );
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }
}
