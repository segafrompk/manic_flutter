import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: Colors.black),
      height: 40,
      child: Center(
        child: Text(
          '\u00a9 2021 MANIC magazine. All rights reserved.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
