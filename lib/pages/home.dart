import 'package:flutter/material.dart';
import 'package:flutter_tests/pages/My.dart';
import 'package:flutter_tests/pages/article_list.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('跳转至第二页'),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SecondScreen()),
            // );
            Navigator.of(context).pushNamed('second_page');
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第二页'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('返回'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _navigatorList = [
    FirstScreen(),
    ArticleList(),
    My(),
  ];

  void handleChangeCurrentIndex(int current) {
    if (current == _currentIndex) {
      return;
    }

    setState(() {
      _currentIndex = current;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigatorList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('主页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('列表'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('我的'),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: handleChangeCurrentIndex,
      ),
    );
  }
}
