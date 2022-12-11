import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  // ♦ Properties:
  String username;
  String comment;
  final dynamic datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;

  // ♦ Constructor:
  Comment({
    required this.username,
    required this.comment,
    required this.datePublished,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
    required this.id,
  });

  // ♦♦ The "toJson()" Method
  //     → for "Converting Data" to an "Object" ("Map"):
  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': comment,
        'datePublished': datePublished,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'id': id,
      };

  // ♦♦ The "fromSnap()" Method
  //     → which will Take a "DocumentSnapshot"
  //     → that it will "Convert" into a "Comment Model":
  static Comment fromSnap(DocumentSnapshot snap) {
    // ♦ Getting "data()" and Marked as "Map<>" ("Object"):
    var snapshot = snap.data() as Map<String, dynamic>;

    // ♦♦ Returning an "Comment Model":
    return Comment(
      username: snapshot['username'],
      comment: snapshot['comment'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      id: snapshot['id'],
    );
  }
}
