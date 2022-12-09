import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/models/user.dart' as model;
import 'package:tiktok_flutter/views/screens/auth/login_screen.dart';
import 'package:tiktok_flutter/views/screens/home_screen.dart';

// ♦♦ The "AuthController" Class
//     → will use the "Get" Package
class AuthController extends GetxController {
  // ♦ Variables:
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  // ♦ Getter
  //   → for Accessing the "Private propery":
  File? get profilePhoto => _pickedImage.value;

  // ♦♦ The "onReady()" Method:
  @override
  void onReady() {
    super.onReady();

    // ♦ Checking if is the Same User:
    _user = Rx<User?>(firebaseAuth.currentUser);

    // ♦ Listening for "Changes" in the "Authentication State:"
    _user.bindStream(firebaseAuth.authStateChanges());

    // ♦ Every time when there is a Change in "_user"
    //   → we "Call" the Method "_setInitialScreen()"
    ever(_user, _setInitialScreen);
  }

  // ♦♦ The "_setInitialScreen()" Method
  //     → for "Redirecting" the "User"
  //     → to the "HomeScreen" if he is "Authenticated":
  _setInitialScreen(User? user) {
    // ♦ Checking the Condition:
    if (user == null) {
      // ♦ Replacing everything with the "LoginScreen()":
      Get.offAll(() => LoginScreen());
    } else {
      // ♦ Replacing everything with the "HomeScreen()":
      Get.offAll(() => const HomeScreen());
    }
  }

  // ♦♦ The "pickImage()" Method:
  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    // ♦ Checking Condition:
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  // ♦♦ Upload "Images" to "Firebase Storage":
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // ♦♦ Registering the User
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // Save out User to our Auth and Firebase Firestore:
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadToStorage(image);

        //♦♦ Creating "User":
        model.User user = model.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
          profilePhoto: downloadUrl,
        );

        // ♦♦ Setting the "user":
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
  }

  // ♦ The "loginUser()" Method:
  void loginUser(String email, String password) async {
    try {
      // ♦ Checking Condition:
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        debugPrint('Login Success!');
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Loggin gin',
        e.toString(),
      );
    }
  }
}
