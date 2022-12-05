import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ♦ Removing the "Debug" Banner:
      debugShowCheckedModeBanner: false,
      title: 'TikTok Clone',
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      home: const Center(
          child: Text(
        'Hello World!',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
