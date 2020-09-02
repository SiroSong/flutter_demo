import 'package:flutter/material.dart';

class Article {
  String title;
  String content;
  bool liked;

  Article(this.title, this.content, this.liked);
}

class ArticleListModel extends ChangeNotifier {
  List<Article> _article = List.generate(
    20,
    (index) => Article('标题$index', 'content$index', false),
  );
  int get total => _article.length;
  List<Article> get articles => _article;

  void mark(index) {
    final Article art = _article[index];
    _article[index] = Article(art.title, art.content, !art.liked);
    notifyListeners();
  }
}
