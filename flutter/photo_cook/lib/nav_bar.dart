// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:photo_cook/screens/cam.dart';
import 'package:photo_cook/screens/home_page.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:photo_cook/screens/search.dart';
import 'package:photo_cook/widgets/coolText.dart';

class Navbar extends StatefulWidget {
  @override
  _Navbar createState() => _Navbar();
}

class _Navbar extends State<Navbar> {
  int _currentPage = 0;
  final _pageController = PageController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          MyHomePage(),
          CameraApp(),
          Search(),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: const Icon(Icons.home),
            title: const coolText(
              text: 'Home',
              fontSize: 12,
            ),
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
          const BottomBarItem(
            icon: Icon(Icons.question_mark_sharp),
            title: coolText(
              text: 'What To Cook',
              fontSize: 11,
            ),
            activeColor: Colors.red,
          ),
          BottomBarItem(
            icon: const Icon(Icons.search),
            title: const coolText(
              text: 'Find Recpies',
              fontSize: 11,
            ),
            backgroundColorOpacity: 0.1,
            activeColor: Colors.greenAccent.shade700,
          ),
        ],
      ),
    );
  }
}
