// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:manic_flutter/model/article.dart';
import 'package:manic_flutter/providers/providers.dart';
import 'package:manic_flutter/view/articleCard.dart';
import 'footer.dart';

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(
        builder: (context, watch, child) {
          final pageData = watch(currentCategoryRepository);
          final currentCategory = watch(categoryProvider).state;
          final int numberOfPagesLoaded = context
              .read(articleRepositoryProvider.notifier)
              .getNumberOfPagesLoaded(currentCategory);
          List homepageWidgetList = pageData['articleData'];
          if (homepageWidgetList.length == 0) {
            watch(articleRepositoryProvider.notifier).fetchPageData();
          }
          List<Widget> finalList = [];
          List<List<Widget>> tempList = [];
          // List addFooter = [];
          int cycle;
          for (int i = 0; i < homepageWidgetList.length; i++) {
            cycle = i ~/ 5;
            if (i % 5 == 0) {
              finalList.add(Container(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: ArticleCard(homepageWidgetList[i])));
              tempList.add([]);
            } else {
              tempList[cycle].add(ArticleCard(homepageWidgetList[i]));
              // Posto nije moglo drugacije, podeseno je da ovako
              // odredjuje visinu karice - sirina ekrana minus padding
              // i razmaci, pa podeljeno na 2 (26 piksela u padding i
              // razmacima, podeljeno xna 2 je 13)

              double cardWidth = MediaQuery.of(context).size.width / 2 - 13;

              if (i % 5 == 4 || i + 1 == homepageWidgetList.length) {
                finalList.add(
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: GridView.count(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      scrollDirection: Axis.vertical,
                      childAspectRatio: (cardWidth) / (2 / 3 * cardWidth + 80),
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
          finalList.add(Footer());

          // watch(rebuildProvider).state;
          return RefreshIndicator(
              onRefresh: () => context
                  .read(articleRepositoryProvider.notifier)
                  .refreshIndicatorFetch(currentCategory),
              child: ListView.builder(
                  // padding: EdgeInsets.all(8),
                  // physics: const NeverScrollableScrollPhysics(),
                  // primary: false,
                  shrinkWrap: true,
                  itemCount: finalList.length,
                  itemBuilder: (BuildContext context, int i) {
                    if (i == finalList.length - 3) {
                      context
                          .read(articleRepositoryProvider.notifier)
                          .loadMoreArticles(
                              currentCategory, numberOfPagesLoaded + 1);
                    }
                    return finalList[i];
                  }));
        },
      ),
    );
  }
}
