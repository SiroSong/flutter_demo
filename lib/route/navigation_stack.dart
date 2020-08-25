import 'package:flutter/material.dart';
import 'package:flutter_tests/pages/article_list.dart';
import 'package:flutter_tests/pages/demo1_navigation.dart';

class HomeStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'home',
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        print(settings.name);
        switch (settings.name) {
          case 'home':
            builder = (BuildContext context) => FirstScreen();
            break;
          case 'second_page':
            builder = (BuildContext context) => SecondScreen();
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
      initialRoute: 'article_list',
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        print(settings.name);
        switch (settings.name) {
          case 'article_list':
            builder = (BuildContext context) => ArticleList();
            break;
          case 'article_content':
            builder = (BuildContext context) =>
                ContentScreen(ModalRoute.of(context).settings.arguments);
            break;
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
