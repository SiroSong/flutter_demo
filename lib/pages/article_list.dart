import 'package:flutter/material.dart';
import 'package:flutter_tests/models/article.dart';
import 'package:flutter_tests/models/model.dart';
import 'package:provider/provider.dart';

class ArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('列表'),
      ),
      body: Selector<ArticleListModel, ArticleListModel>(
        shouldRebuild: (previous, next) => false,
        selector: (context, provider) => provider,
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.total,
            itemBuilder: (context, index) {
              return Selector<ArticleListModel, Article>(
                // shouldRebuild: (previous, next) => previous.liked != next.liked,
                selector: (context, provider) => provider.articles[index],
                builder: (context, data, child) {
                  return ListTile(
                    title: Text(data.title),
                    trailing: GestureDetector(
                      onTap: () => provider.mark(index),
                      child: Icon(data.liked ? Icons.star : Icons.star_border),
                    ),
                    onTap: () async {
                      MarkResult result = await Navigator.pushNamed<dynamic>(
                        context,
                        'article_content',
                        arguments: data,
                      );

                      if (result != null) {
                        if (result.key != data.liked) {
                          provider.mark(index);
                        }

                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('${result.value} ${data.title}'),
                          duration: const Duration(seconds: 1),
                        ));
                      }
                    },
                  );
                },
              );
            },
          );
        },
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
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(_article.content),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context, MarkResult(true, '喜欢'));
                      },
                      child: Text('喜欢'),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context, MarkResult(false, '不喜欢'));
                      },
                      child: Text('不喜欢'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
