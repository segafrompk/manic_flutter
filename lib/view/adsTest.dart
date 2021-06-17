import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsTest extends StatefulWidget {
  @override
  _AdsTestState createState() => _AdsTestState();
}

class _AdsTestState extends State<AdsTest> {
  InterstitialAd? _interstitialAd;

  // int _numInterstitialLoadAttempts = 0;

  @override
  initState() {
    super.initState();
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            print('Ad loaded');
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: ElevatedButton(
            onPressed: () {
              if (_interstitialAd != null) {
                _interstitialAd!.show();
              }
            },
            child: Text('Hello'),
          ),
        ),
      ),
    );
  }
}
