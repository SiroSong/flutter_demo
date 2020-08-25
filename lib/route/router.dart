import 'package:flutter/material.dart';
import 'package:flutter_tests/pages/article_list.dart';
import 'package:flutter_tests/pages/demo1_navigation.dart';
import 'package:flutter_tests/route/navigation_stack.dart';

class Router extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RouterState();
  }
}

class RouterState extends State<Router> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeStack(),
    ArticleStack(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('主页')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('列表')),
        ],
        currentIndex: _currentIndex,
        onTap: onTabTapped,
      ),
    );
  }
}
