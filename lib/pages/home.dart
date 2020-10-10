import 'package:flutter/material.dart';
import 'package:flutter_tests/models/counter.dart';
import 'package:flutter_tests/pages/My.dart';
import 'package:flutter_tests/pages/article_list.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
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

class HomeState extends State<Home> with TickerProviderStateMixin {
  static const double MAXLEFT = 150;
  static const double MINSCALE = 0.8;

  int _currentIndex = 0;
  final List<Widget> _navigatorList = [
    FirstScreen(),
    ArticleList(),
    My(),
  ];
  double _left = 0;
  double _scale = 1;
  double startPos = 0;
  bool manual = false;
  bool dragStatus = false;
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1300),
    );
    _animation = Tween<double>(begin: 1, end: MINSCALE).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragStart: (details) {
          manual = true;
          startPos = details.localPosition.dx;
        },
        onHorizontalDragUpdate: panUpdateHandle,
        onHorizontalDragEnd: (details) {
          print('99999999');
          manual = false;
          _animation =
              Tween<double>(begin: _scale, end: MINSCALE).animate(_controller)
                ..addStatusListener((status) {
                  if (status == AnimationStatus.completed) {
                    _scale = MINSCALE;
                  } else {
                    _scale = 1;
                  }
                });
          if (_controller.status == AnimationStatus.completed) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        child: Stack(
          children: <Widget>[
            Scaffold(
              body: Center(
                child: Text('back page'),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  left: _left,
                  // left: manual ? _left : MAXLEFT * _controller.value,
                  child: Transform.scale(
                    // scale: _animation.value,
                    scale: manual ? _scale : _animation.value,
                    child: child,
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Scaffold(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleChangeCurrentIndex(int current) {
    if (current == _currentIndex) {
      return;
    }
    setState(() {
      _currentIndex = current;
    });
  }

  void panUpdateHandle(DragUpdateDetails details) {
    setState(() {
      double location = details.delta.dx + _left;
      if (location >= 0 && location <= MAXLEFT) {
        _left = location;
        _scale = 1 - (_left / 150) * (1 - MINSCALE);
      }
      if (location > MAXLEFT) {
        _left = MAXLEFT;
        _scale = MINSCALE;
        dragStatus = true;
      }
      if (location < 0) {
        _left = 0;
        _scale = 1;
        dragStatus = false;
      }
    });
  }
}
