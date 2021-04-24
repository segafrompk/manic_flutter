import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manic_flutter/view/body.dart';
import 'view/footer.dart';
import 'view/menu.dart';

void main() {
  runApp(
    ProviderScope(
      child: ManicUI(),
    ),
  );
}

class ManicUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              TopBar(),
              AppBody(),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ManicLogo(),
        MenuBar(),
      ],
    );
  }
}
