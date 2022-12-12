import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/constants.dart';

class ProfileController extends GetxController {
  // ♦ Private Property:
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  // ♦ Getter → for Accessing the "Private Property":
  Map<String, dynamic> get user => _user.value;

  // ♦ Variable
  final Rx<String> _uid = "".obs;

  // ♦ The "updateUserId()" Function:
  updateUserId(String uid) {
    _uid.value = uid;

    // ♦ Calling the Function:
    getUserData();
  }

  // ♦ The "getUserData()" Function:
  getUserData() async {
    // ♦ Creating "Thumbnails" List:
    List<String> thumbnails = [];

    // ♦ Getting "Videos" for an "User ID":
    var myVideos = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    // ♦ Adding "Video" to the "List":
    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    }

    // ♦ Getting the "User ID":
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    // ♦ Storing "User Data"L
    final userData = userDoc.data()! as dynamic;

    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    // ♦ Adding "Likes" for "Videos"
    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    // ♦ Creating "Followers" Sub-Collection:
    var followerDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();

    // ♦ Creating "Following" Sub-Collection:
    var followingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();

    // ♦ Getting the "Number" of "Follower":
    followers = followerDoc.docs.length;
    // ♦ Getting the "Following" of "Follower":
    following = followingDoc.docs.length;

    // ♦ Checking if the "User Following":
    firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then(
      (value) {
        if (value.exists) {
          isFollowing = true;
        } else {
          isFollowing = false;
        }
      },
    );

    // ♦ Setting "User Value":
    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnails': thumbnails,
    };

    update();
  }

  // ♦ The "followUser()" Function:
  followUser() async {
    // ♦ Getting "User ID" from "Followers" Collection:
    var doc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();

    // ♦ Checking the Condition:
    if (!doc.exists) {
      // ♦ Adding the "User" to "Followers" Collection:
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});

      // ♦ Adding the "User" to "Following" Collection:
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});

      // ♦ Updating the "Followers" Collection by "Adding Follower":
      _user.value.update(
        'followers',
        (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      // ♦ Removing the "User" from "Followers" Collection:
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();

      // ♦ Removing the "User" from "Following" Collection:
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();

      // ♦ Updating the "Followers" Collection by "Removing Follower":
      _user.value.update(
        'followers',
        (value) => (int.parse(value) - 1).toString(),
      );
    }

    // ♦ Updating the "Following":
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
