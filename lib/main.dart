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
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      primarySwatch: Colors.cyan,
      // This makes the visual density adapt to the platform that you run
      // the app on. For desktop platforms, the controls will be smaller and
      // closer together (more dense) than on mobile platforms.
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
