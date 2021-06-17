import '../model/article.dart';

List<Article> convertToList(data) {
  List<Article> homepageWidgetList = [];
  if (data is Map) {
    for (var articleData in data.values) {
      if (articleData is Map<String, dynamic> &&
          articleData['articleId'] != null) {
        homepageWidgetList.add(Article.fromJson(articleData));
      }
    }
  } else if (data is List) {
    for (var articleData in data) {
      if (articleData is Map<String, dynamic> &&
          articleData['articleId'] != null) {
        homepageWidgetList.add(Article.fromJson(articleData));
      }
    }
  }
  return homepageWidgetList;
}
