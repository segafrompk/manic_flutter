// import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:manic_flutter/helper/constants.dart';
import 'package:manic_flutter/model/article.dart';
import 'package:manic_flutter/view/gallery.dart';
import 'package:manic_flutter/view/menu.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'recommended.dart';

// TODO: Ocisti widget, sredi twitter embed preko iframe-a, dodaj RefreshIndicator

class DetailScreen extends StatefulWidget {
  final Article articleData;
  DetailScreen({required this.articleData});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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

        bool isCaptioned = match[0]!.contains('data-instgrm-captioned');

        if (linkMatch != null) {
          String iframe =
              "<iframe src='${linkMatch[0]}/embed${isCaptioned ? '/captioned' : ''}' frameborder='0' scrolling='no' allowtransparency='true'></iframe>";
          return iframe;
        }
        return match[0]!;
      }
      return '';
    });
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
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              ),
              onPressed: () => Navigator.pop(context),
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
                aspectRatio: 16 / 9,
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
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffba4120),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Text(
                        this
                            .widget
                            .articleData
                            .category['categoryName']
                            .toUpperCase(),
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'RobotoSlab',
                            height: 1,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      this.widget.articleData.title,
                      style: TextStyle(fontSize: 30, fontFamily: 'BebasNeue'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    HtmlWidget(
                      parseArticleBodyForEmbeds(
                          this.widget.articleData.articleBody),
                      webView: true,
                      customWidgetBuilder: (element) {
                        if (element.localName == 'gallery') {
                          Map gallery = {};
                          if (this.widget.articleData.galleries.length > 0) {
                            gallery = this
                                .widget
                                .articleData
                                .galleries
                                .firstWhere((gallery) =>
                                    gallery['slug'] == element.innerHtml);
                          }
                          if (gallery['galleryImages'] != null) {
                            return ImageGallery(
                                gallery: gallery['galleryImages']);
                          } else {
                            return null;
                          }
                        }

                        return null;
                      },
                      customStylesBuilder: (element) {
                        if (element.outerHtml.contains('p')) {
                          return {
                            'font-family': 'RobotoSlabLight',
                            'font-weight': '100',
                            'font-size': '16px'
                          };
                        }

                        return null;
                      },
                    ),
                    RecommendedArticles(
                        articleId: this.widget.articleData.articleId),
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
