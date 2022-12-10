import 'package:cloud_firestore/cloud_firestore.dart';

// ♦ Uploading the Video in Firebase
//   → by Creating the "Video" Model:
class Video {
  // ♦ Properties:
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePhoto;

  // ♦ Constructor:
  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.profilePhoto,
    required this.thumbnail,
  });

  // ♦♦ The "toJson()" Method
  //     → for "Converting Data" to an "Object" ("Map"):
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "profilePhoto": profilePhoto,
        "id": id,
        "likes": likes,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "songName": songName,
        "caption": caption,
        "videoUrl": videoUrl,
        "thumbnail": thumbnail,
      };

  // ♦♦ The "fromSnap()" Method
  //     → which will Take a "DocumentSnapshot"
  //     → that it will "Convert" into a "Video Model":
  static Video fromSnap(DocumentSnapshot snap) {
    // ♦ Getting "data()" and Marked "as Map<>":
    var snapshot = snap.data() as Map<String, dynamic>;

    // ♦♦ Returning an "Video Model":
    return Video(
      username: snapshot['username'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      commentCount: snapshot['commentCount'],
      shareCount: snapshot['shareCount'],
      songName: snapshot['songName'],
      caption: snapshot['caption'],
      videoUrl: snapshot['videoUrl'],
      profilePhoto: snapshot['profilePhoto'],
      thumbnail: snapshot['thumbnail'],
    );
  }
}
