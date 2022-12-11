import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/models/comment.dart';

class CommentController extends GetxController {
  // ♦ "Private Property":
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);

  // ♦ Getter → for Accessing "Private Property":
  List<Comment> get comments => _comments.value;

  // ♦ Variable:
  String _postId = "";

  // ♦ The "updatePostId()" Function:
  updatePostId(String id) {
    _postId = id;

    // ♦ Calling the Function:
    getComment();
  }

  // ♦ The "getComment()" Function:
  getComment() async {
    // ♦ Getting All List of "Comments":
    _comments.bindStream(
      firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<Comment> retValue = [];
          for (var element in query.docs) {
            retValue.add(Comment.fromSnap(element));
          }
          return retValue;
        },
      ),
    );
  }

  // ♦ The "postComment()" Function:
  postComment(String commentText) async {
    try {
      // ♦ Checking the Condition:
      if (commentText.isNotEmpty) {
        // ♦ Getting the "User ID":
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(authController.user.uid)
            .get();

        // ♦ Getting All the "Comments" for a "Video ID":
        var allDocs = await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();

        // ♦ Getting the "Number of Comments":
        int len = allDocs.docs.length;

        // ♦ Creating the "Comment":
        Comment comment = Comment(
          username: (userDoc.data()! as dynamic)['name'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: (userDoc.data()! as dynamic)['profilePhoto'],
          uid: authController.user.uid,
          id: 'Comment $len',
        );

        // ♦ Saving in Firebase "Database":
        await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $len')
            .set(
              comment.toJson(),
            );

        // ♦ Getting the "Post ID"
        DocumentSnapshot doc =
            await firestore.collection('videos').doc(_postId).get();

        // ♦ Updating the "Number of Comments":
        await firestore.collection('videos').doc(_postId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      }
    } catch (e) {
      // ♦ Error Message:
      Get.snackbar(
        'Error While Commenting',
        e.toString(),
      );
    }
  }

  // ♦ The "likeComment()" Function:
  likeComment(String id) async {
    // ♦ Getting "User ID":
    var uid = authController.user.uid;

    // ♦ Getting "Comment ID"
    DocumentSnapshot doc = await firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    // ♦ Checking the Condition:
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      // ♦ Remove "Comment Like":
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      // ♦ Add "Comment Like":
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
