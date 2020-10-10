import 'package:flutter/material.dart';
import 'package:flutter_tests/models/article.dart';
import 'package:flutter_tests/models/counter.dart';
import 'package:flutter_tests/pages/article_list.dart';
import 'package:flutter_tests/pages/home.dart';
import 'package:flutter_tests/pages/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider>[
        ChangeNotifierProvider<CounterModel>(create: (_) => CounterModel()),
        ChangeNotifierProvider<ArticleListModel>(
            create: (_) => ArticleListModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(
      primarySwatch: Colors.cyan,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return MaterialApp(
      theme: themeData,
      initialRoute: 'home',
      routes: <String, WidgetBuilder>{
        'home': (BuildContext context) => Home(),
        'second_page': (BuildContext context) => SecondScreen(),
        'article_content': (BuildContext context) =>
            ContentScreen(ModalRoute.of(context).settings.arguments),
        'login': (BuildContext context) => Login(),
      },
    );
  }
}
