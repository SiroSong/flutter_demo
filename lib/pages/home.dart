import 'package:flutter/material.dart';
import 'package:flutter_tests/models/counter.dart';
import 'package:flutter_tests/pages/My.dart';
import 'package:flutter_tests/pages/article_list.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('second_page');
                },
                child: Text('跳转至第二页'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('login');
                },
                child: Text('登陆'),
              ),
            ],
          ),
          Consumer<CounterModel>(
            builder: (context, CounterModel counter, _) => Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    counter.increment();
                  },
                  child: Text('${counter.value}'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('第二页'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('返回${counter.value}'),
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
