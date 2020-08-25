import 'package:flutter/material.dart';
import 'package:flutter_tests/pages/article_list.dart';
import 'package:flutter_tests/pages/demo1_navigation.dart';

class HomeStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        print(settings.name);
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => FirstScreen();
            break;
          case '/second_page':
            builder = (BuildContext context) => SecondScreen();
            break;
          default:
            break;
        }

        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },
    );
  }
}

class ArticleStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => ArticleList();
            break;
          case '/article_content':
            builder = (BuildContext context) =>
                ContentScreen(ModalRoute.of(context).settings.arguments);
            break;
          default:
            builder = (BuildContext context) => ArticleList();
            break;
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
