// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manic_flutter/model/article.dart';
import 'package:manic_flutter/providers/providers.dart';
import 'package:manic_flutter/view/articleCardBig.dart';

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(builder: (context, watch, child) {
        final pageData =
            watch(articleRepositoryProvider.notifier).fetchPageData();
        final currentCategory = watch(categoryProvider).state;
        watch(rebuildProvider).state;
        return RefreshIndicator(
          onRefresh: () => context
              .read(articleRepositoryProvider.notifier)
              .refreshIndicatorFetch(currentCategory),
          child: FutureBuilder(
              future: pageData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Container(
                      child: Text('There was an error, please refresh!'),
                    );
                  } else if (snapshot.hasData) {
                    List<Article> homepageWidgetList = snapshot.data;
                    // if (snapshot.data is Map) {
                    //   for (var articleData in snapshot.data.values) {
                    //     if (articleData is Map<String, dynamic> &&
                    //         articleData['articleId'] != null) {
                    //       homepageWidgetList.add(Article.fromJson(articleData));
                    //     }
                    //   }
                    // } else if (snapshot.data is List) {
                    //   for (var articleData in snapshot.data) {
                    //     if (articleData is Map<String, dynamic> &&
                    //         articleData['articleId'] != null) {
                    //       homepageWidgetList.add(Article.fromJson(articleData));
                    //     }
                    //   }
                    // }
                    List<Widget> finalList = [];
                    List<List<Widget>> tempList = [];
                    int cycle;
                    for (int i = 0; i < homepageWidgetList.length; i++) {
                      cycle = i ~/ 5;
                      if (i % 5 == 0) {
                        finalList.add(ArticleCardBig(homepageWidgetList[i]));
                        tempList.add([]);
                      } else {
                        tempList[cycle]
                            .add(ArticleCardBig(homepageWidgetList[i]));
                        // Posto nije moglo drugacije, podeseno je da ovako
                        // odredjuje visinu karice - sirina ekrana minus padding i
                        // razmaci, pa podeljeno na 2 (26 piksela u padding i
                        // razmacima, podeljeno xna 2 je 13)

                        double cardWidth =
                            MediaQuery.of(context).size.width / 2 - 13;

                        if (i % 5 == 4 || i + 1 == homepageWidgetList.length) {
                          finalList.add(
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 0),
                              child: GridView.count(
                                scrollDirection: Axis.vertical,
                                childAspectRatio: cardWidth / (cardWidth + 80),
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                shrinkWrap: true,
                                primary: false,
                                children: tempList[cycle],
                              ),
                            ),
                          );
                        }
                      }
                    }
                    return ListView.builder(
                      padding: EdgeInsets.all(8),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: finalList.length,
                      itemBuilder: (BuildContext context, int i) {
                        return finalList[i];
                      },
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              }),
        );
      }),
    );
  }
}
