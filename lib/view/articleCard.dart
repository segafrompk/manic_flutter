import 'package:flutter/material.dart';
import 'package:manic_flutter/model/article.dart';
import '../helper/constants.dart';
import 'detailScreen.dart';

class ArticleCard extends StatelessWidget {
  final Article articleData;
  ArticleCard(this.articleData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                DetailScreen(articleData: articleData),
            transitionDuration: Duration(milliseconds: 0),
          ),
        );
      },
      child: Container(
        // decoration: BoxDecoration(
        //   boxShadow: [
        //     BoxShadow(
        //       color: Color(0x1f000000),
        //       blurRadius: 7,
        //       spreadRadius: 2,
        //     ),
        //   ],
        // ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child: Image.network('https://' +
                    apiAddress +
                    articleData.articleCover['formats']['medium']['url']),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFf0f0f0),
              ),
              width: double.infinity,
              height: 80,
              padding: EdgeInsets.fromLTRB(8, 13, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${articleData.category['categoryName']}'.toUpperCase(),
                    style: TextStyle(
                        fontFamily: 'Vollkorn Regular',
                        fontSize: 12,
                        height: 1),
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
      ),
    );
  }
}
