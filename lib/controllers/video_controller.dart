import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/models/video.dart';

class VideoController extends GetxController {
  // ♦ "Private Property":
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  // ♦ Getter → for Accessing "Private Property":
  List<Video> get videoList => _videoList.value;

  // ♦ The "onInit()" Method:
  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(
        firestore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          Video.fromSnap(element),
        );
      }
      return retVal;
    }));
  }

  // ♦ The "likeVideo()" Function:
  likeVideo(String id) async {
    // ♦ Getting "Video ID":
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();

    // ♦ Getting "User ID":
    var uid = authController.user.uid;

    // ♦ Checking the Condition:
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      // ♦ Remove "Like":
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      // ♦ Add "Like":
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
