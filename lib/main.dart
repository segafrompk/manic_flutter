import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manic_flutter/view/body.dart';
// import 'view/footer.dart';
import 'view/menu.dart';
// import './view/adsTest.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

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
      themeMode: ThemeMode.light,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              TopBar(),
              // Builder(
              //   builder: (context) => TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         PageRouteBuilder(
              //           pageBuilder: (context, animation1, animation2) =>
              //               AdsTest(),
              //           transitionDuration: Duration(milliseconds: 0),
              //         ),
              //       );
              //     },
              //     child: Text('Hello'),
              //   ),
              // ),
              AppBody(),
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
