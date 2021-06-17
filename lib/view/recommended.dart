import 'dart:convert';

import 'package:manic_flutter/model/article.dart';
import 'package:manic_flutter/view/articleCard.dart';

import '../helper/convert.dart';
import 'package:flutter/material.dart';
import 'package:manic_flutter/helper/urlRequest.dart';

class RecommendedArticles extends StatefulWidget {
  final String articleId;
  RecommendedArticles({required this.articleId});

  @override
  _RecommendedArticlesState createState() => _RecommendedArticlesState();
}

class _RecommendedArticlesState extends State<RecommendedArticles> {
  List<Article> recommendedList = [];

  void getRecommendedArticles(String id) async {
    try {
      var response = await fetchFromApiUrlPath('/articles/$id/related');
      var repository = jsonDecode(response.body);

      setState(() {
        recommendedList = convertToList(repository);
      });
    } catch (e) {
      setState(() {
        recommendedList = [];
      });
    }
  }

  @override
  initState() {
    super.initState();
    getRecommendedArticles(this.widget.articleId);
  }

  @override
  Widget build(BuildContext context) {
    List<ArticleCard> tempList = [];
    for (int i = 0; i < recommendedList.length; i++) {
      tempList.add(ArticleCard(recommendedList[i]));
    }

    double cardWidth = MediaQuery.of(context).size.width / 2 - 25;
    if (tempList.length > 0) {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: GridView.count(
          childAspectRatio: (cardWidth) / (2 / 3 * cardWidth + 80),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          primary: false,
          children: tempList,
        ),
      );
    } else {
      return Container();
    }
  }
}
