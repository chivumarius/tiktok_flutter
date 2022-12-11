import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  // ♦ Property:
  final String uid;

  // ♦ Constructor:
  const ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  // ♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
