import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  TestPage({
    Key key,
    this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    // return Text('this is new page, index is $title');
    return Scaffold(
      appBar: AppBar(
        title: Text('tip'),
      ),
      body: Text('this is new page, this page index is $title'),
    );
  }
}
