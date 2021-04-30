// import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:manic_flutter/helper/constants.dart';
import 'package:manic_flutter/model/article.dart';
import 'package:manic_flutter/view/menu.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_plus/webview_flutter_plus.dart';

// TODO: Ocisti widget, sredi twitter embed preko iframe-a, dodaj RefreshIndicator

class DetailScreen extends StatefulWidget {
  final Article articleData;
  DetailScreen({required this.articleData});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // late WebViewPlusController _controller;
  // double _height = 600;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  RegExp findInstagramBlock =
      RegExp("<blockquote.+class=\\\"instagram-media.+<\/blockquote>");

  RegExp findInstagramLink = RegExp(
      r"https?:\/\/www\.instagram\.com\/(p|tv)\/.{3,12}(?=\/\?utm_source)");

  String parseArticleBodyForEmbeds(String articleBody) {
    String newArticleBody =
        articleBody.replaceAllMapped(findInstagramBlock, (Match match) {
      var linkMatch;
      if (match[0] != null) {
        linkMatch = findInstagramLink.firstMatch(match[0]!);

        print('Match is...');
        print(match[0]);
        if (linkMatch?[0] != null) {
          print('Captured link is...');
          print(linkMatch[0]);
        }

        bool isCaptioned = match[0]!.contains('data-instgrm-captioned');

        if (linkMatch != null) {
          String iframe =
              "<iframe src='${linkMatch[0]}/embed${isCaptioned ? '/captioned' : ''}' frameborder='0' scrolling='no' allowtransparency='true'></iframe>";
          print(iframe);
          return iframe;
        }
        return match[0]!;
      }
      return '';
    });
    // print(newArticleBody);
    return newArticleBody;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: ManicLogo(),
            centerTitle: true,
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              ),
              onTap: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                splashColor: Colors.white,
                icon: Icon(
                  Icons.share,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: ListView(
            // shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: Image.network('https://' +
                      apiAddress +
                      this.widget.articleData.articleCover['formats']['medium']
                          ['url']),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this
                          .widget
                          .articleData
                          .category['categoryName']
                          .toUpperCase(),
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'Vollkorn Regular'),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      this.widget.articleData.title,
                      style: TextStyle(fontSize: 20, fontFamily: 'BebasNeue'),
                    ),
                    HtmlWidget(
                      parseArticleBodyForEmbeds(
                          this.widget.articleData.articleBody),
                      webView: true,
                    ),
                  ],
                ),
              ),

              // SizedBox(
              //   height: _height,
              //   width: MediaQuery.of(context).size.width,
              //   child: WebViewPlus(
              //     initialUrl: 'about:blank',
              //     javascriptMode: JavascriptMode.unrestricted,
              //     navigationDelegate: (navigation) =>
              //         NavigationDecision.navigate,
              //     onWebViewCreated: (WebViewPlusController webViewController) {
              //       this._controller = webViewController;
              //       _controller.loadUrl(Uri.dataFromString(
              //               this.widget.articleData.articleBody,
              //               mimeType: 'text/html',
              //               encoding: Encoding.getByName('utf-8'))
              //           .toString());
              //     },
              //     onPageFinished: (url) {
              //       _controller.getHeight().then((height) {
              //         if (height is double) {
              //           print("Height set to:  " + height.toString());
              //           setState(() {
              //             _height = height + 1;
              //           });
              //         }
              //       });
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
// controller.loadUrl(Uri.dataFromString("your html", mimeType: 'text/html', encoding: utf8).toString());
