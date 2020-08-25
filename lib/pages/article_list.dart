import 'package:flutter/material.dart';
import 'package:flutter_tests/state/article.dart';

class ArticleList extends StatelessWidget {
  final List<Article> articles = List.generate(
      10, (index) => Article('art title $index', 'art content $index'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('article list'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(articles[index].title),
            onTap: () async {
              // String result = await Navigator.push(
              //     context,
              //     // MaterialPageRoute(
              //     //     builder: (context) => ContentScreen(articles[index]))
              //     PageRouteBuilder(
              //         pageBuilder: (context, _, __) =>
              //             ContentScreen(articles[index]),
              //         transitionsBuilder:
              //             (_, Animation<double> animation, __, Widget child) =>
              //                 FadeTransition(
              //                   opacity: animation,
              //                   child: RotationTransition(
              //                     turns: Tween<double>(begin: 0.0, end: 1.0)
              //                         .animate(animation),
              //                     child: child,
              //                   ),
              //                 )));
              String result = await Navigator.pushNamed<dynamic>(
                context,
                'article_content',
                arguments: articles[index],
              );

              if (result != null) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(result),
                  duration: const Duration(seconds: 1),
                ));
              }
            },
          );
        },
        itemCount: articles.length,
      ),
    );
  }
}

class ContentScreen extends StatelessWidget {
  final Article _article;

  ContentScreen(this._article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_article.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text(_article.content),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context, 'Like');
                  },
                  child: Text('Like'),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context, 'unlike');
                  },
                  child: Text('unlike'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
