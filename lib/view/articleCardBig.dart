import 'package:flutter/material.dart';
import 'package:manic_flutter/model/article.dart';
import '../helper/constants.dart';
import 'detailScreen.dart';

class ArticleCardBig extends StatelessWidget {
  final Article articleData;
  ArticleCardBig(this.articleData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(articleData: articleData),
          ),
        );
      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: Image.network('https://' +
                  apiAddress +
                  articleData.articleCover['formats']['medium']['url']),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Color(0xFFf0f0f0)),
            width: double.infinity,
            height: 80,
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${articleData.category['categoryName']}'.toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'Vollkorn Regular', fontSize: 12, height: 1),
                ),
                SizedBox(height: 6),
                Text(
                  '${articleData.title}',
                  maxLines: 2,
                  style: TextStyle(
                      fontFamily: 'BebasNeue', fontSize: 20, height: 1),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
