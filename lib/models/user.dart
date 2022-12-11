import 'package:cloud_firestore/cloud_firestore.dart';

// ♦ Uploading the User in Firebase
//   → by Creating the "User" Model:
class User {
  // ♦♦ Properties:
  String name;
  String profilePhoto;
  String email;
  String uid;

  // ♦♦ Constructor:
  User({
    required this.name,
    required this.email,
    required this.uid,
    required this.profilePhoto,
  });

  // ♦♦ The "toJson()" Method
  //     → for "Converting Data" to an "Object" ("Map"):
  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePhoto": profilePhoto,
        "email": email,
        "uid": uid,
      };

  // ♦♦ The "fromSnap()" Method
  //     → which will Take a "DocumentSnapshot"
  //     → that it will "Convert" into a "User Model":
  static User fromSnap(DocumentSnapshot snap) {
    // ♦ Getting "data()" and Marked as "Map<>" ("Object"):
    var snapshot = snap.data() as Map<String, dynamic>;

    // ♦♦ Returning an "User Model":
    return User(
      email: snapshot['email'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      name: snapshot['name'],
    );
  }
}
