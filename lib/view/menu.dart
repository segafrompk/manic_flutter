import 'package:flutter/material.dart';
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
      child: SizedBox(
        height: 42,
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(width: menuEdgesPadding),
                  MenuItem(
                    title: 'TOP STORIES',
                    highlight: true,
                  ),
                  SizedBox(width: menuItemsPadding),
                  MenuItem(title: 'MUSIC'),
                  SizedBox(width: menuItemsPadding),
                  MenuItem(title: 'MOVIES'),
                  SizedBox(width: menuItemsPadding),
                  MenuItem(title: 'GIRLS'),
                  SizedBox(width: menuItemsPadding),
                  MenuItem(title: 'STYLE PLANNER'),
                  SizedBox(width: menuItemsPadding),
                  MenuItem(title: 'GEAR'),
                  SizedBox(width: menuItemsPadding),
                  MenuItem(title: 'FITNESS'),
                  SizedBox(width: menuItemsPadding),
                  MenuItem(title: 'CULTURE & ART'),
                  SizedBox(width: menuItemsPadding),
                  MenuItem(title: 'TRAVEL'),
                  SizedBox(width: menuItemsPadding),
                  MenuItem(title: 'LYFESTYLE'),
                  SizedBox(width: menuItemsPadding),
                  MenuItem(title: 'GROOMING'),
                  SizedBox(width: menuItemsPadding),
                  MenuItem(title: 'SUBSCRIBE'),
                  SizedBox(width: menuEdgesPadding),
                ],
              ),
            ),
          ],
        ),
      ),
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
