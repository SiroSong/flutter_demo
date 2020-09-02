import 'package:flutter/material.dart';

class My extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的主页'),
      ),
      body: Column(
        children: [
          Row(
            children: [Text('订单中心')],
          ),
          Row(
            children: [Text('个人信息')],
          ),
          Row(
            children: [Text('通用设置')],
          ),
        ],
      ),
    );
  }
}
