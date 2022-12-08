import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/controllers/auth_controller.dart';
// import 'package:tiktok_flutter/views/screens/auth/login_screen.dart';
import 'package:tiktok_flutter/views/screens/auth/signup_screen.dart';

void main() async {
  // ♦ Initialize the Widget:
  WidgetsFlutterBinding.ensureInitialized();

  // ♦ Initialize the App on Firebase:
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ♦ Constructor
  const MyApp({super.key});

  // This Widget is the Root of your Application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // ♦ Removing the "Debug" Banner:
      debugShowCheckedModeBanner: false,
      title: 'TikTok Clone',
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      home: SignupScreen(),
    );
  }
}
