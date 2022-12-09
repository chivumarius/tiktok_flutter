import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/views/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ♦ Variable:
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          setState(() {
            pageIdx = idx;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: pageIdx,

        // ♦ Items List:
        items: const [
          // ♦ "Home" Item:
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),

          // ♦ "Search" Item:
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            label: 'Search',
          ),

          // ♦ "Add Icon" Item:
          BottomNavigationBarItem(
            icon: CustomIcon(),
            label: '',
          ),

          // ♦ "Messages" Item:
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 30),
            label: 'Messages',
          ),

          // ♦ "Profile" Item:
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: 'Profile',
          ),
        ],
      ),
      body: Center(
        child: pages[pageIdx],
      ),
    );
  }
}
