import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manic_flutter/providers/providers.dart';
import '../helper/constants.dart';

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: borderColor),
          bottom: BorderSide(width: 1.0, color: borderColor),
        ),
      ),
      child: Consumer(builder: (context, watch, child) {
        var categoryState = watch(categoryProvider);
        String currentCategory = categoryState.state;
        void goToCategory(String x) {
          categoryState.state = x;
          context.read(articleRepositoryProvider.notifier).fetchPageData();
        }

        return SizedBox(
          height: 42,
          child: CustomScrollView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(width: menuEdgesPadding),
                    GestureDetector(
                      onTap: () => goToCategory('homepage'),
                      child: MenuItem(
                        title: 'TOP STORIES',
                        highlight: currentCategory == 'homepage' ? true : false,
                      ),
                    ),
                    SizedBox(width: menuItemsPadding),
                    GestureDetector(
                        onTap: () => goToCategory('categories/music'),
                        child: MenuItem(
                          title: 'MUSIC',
                          highlight: currentCategory == 'categories/music'
                              ? true
                              : false,
                        )),
                    SizedBox(width: menuItemsPadding),
                    GestureDetector(
                        onTap: () => goToCategory('categories/movies'),
                        child: MenuItem(
                          title: 'MOVIES',
                          highlight: currentCategory == 'categories/movies'
                              ? true
                              : false,
                        )),
                    SizedBox(width: menuItemsPadding),
                    GestureDetector(
                        onTap: () => goToCategory('categories/girls'),
                        child: MenuItem(
                          title: 'GIRLS',
                          highlight: currentCategory == 'categories/girls'
                              ? true
                              : false,
                        )),
                    SizedBox(width: menuItemsPadding),
                    GestureDetector(
                        onTap: () => goToCategory('categories/style-planner'),
                        child: MenuItem(
                          title: 'STYLE PLANNER',
                          highlight:
                              currentCategory == 'categories/style-planner'
                                  ? true
                                  : false,
                        )),
                    SizedBox(width: menuItemsPadding),
                    GestureDetector(
                        onTap: () => goToCategory('categories/gear'),
                        child: MenuItem(
                          title: 'GEAR',
                          highlight: currentCategory == 'categories/gear'
                              ? true
                              : false,
                        )),
                    SizedBox(width: menuItemsPadding),
                    GestureDetector(
                        onTap: () => goToCategory('categories/fitness'),
                        child: MenuItem(
                          title: 'FITNESS',
                          highlight: currentCategory == 'categories/fitness'
                              ? true
                              : false,
                        )),
                    SizedBox(width: menuItemsPadding),
                    GestureDetector(
                        onTap: () => goToCategory('categories/culture-and-art'),
                        child: MenuItem(
                          title: 'CULTURE & ART',
                          highlight:
                              currentCategory == 'categories/culture-and-art'
                                  ? true
                                  : false,
                        )),
                    SizedBox(width: menuItemsPadding),
                    GestureDetector(
                        onTap: () => goToCategory('categories/travel'),
                        child: MenuItem(
                          title: 'TRAVEL',
                          highlight: currentCategory == 'categories/travel'
                              ? true
                              : false,
                        )),
                    SizedBox(width: menuItemsPadding),
                    GestureDetector(
                        onTap: () => goToCategory('categories/lifestyle'),
                        child: MenuItem(
                          title: 'LIFESTYLE',
                          highlight: currentCategory == 'categories/lifestyle'
                              ? true
                              : false,
                        )),
                    SizedBox(width: menuItemsPadding),
                    GestureDetector(
                        onTap: () => goToCategory('categories/grooming'),
                        child: MenuItem(
                          title: 'GROOMING',
                          highlight: currentCategory == 'categories/grooming'
                              ? true
                              : false,
                        )),
                    SizedBox(width: menuItemsPadding),
                    MenuItem(title: 'SUBSCRIBE'),
                    SizedBox(width: menuEdgesPadding),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ManicLogo extends StatelessWidget {
  const ManicLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage('assets/images/logo-glavni.png'),
        height: 25.6,
      ),
      padding: EdgeInsets.all(17.2),
      height: 60,
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    this.highlight = false,
    this.title = '',
  }) : super(key: key);
  // final Color manicOrange = const Color(0xFFBA4120);
  final String title;
  final bool highlight;
  final borderNone = BorderSide.none;
  final borderHighlight = const BorderSide(
    width: 2.0,
    color: manicOrange,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: highlight ? borderHighlight : borderNone,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 13, 0, highlight ? 8 : 10),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'BebasNeue',
              height: 1,
              color: highlight ? manicOrange : Colors.black),
        ),
      ),
    );
  }
}
