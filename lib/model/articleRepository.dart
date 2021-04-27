import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manic_flutter/helper/urlRequest.dart';
import 'package:manic_flutter/providers/providers.dart';
import 'article.dart';

// TODO: Razdvoji provider za trenutnu kategoriju od baze za sve kategorije
// kojima je pristupano

class ArticleRepository extends StateNotifier<Map<String, Map>> {
  ProviderReference providerRef;
  ArticleRepository(this.providerRef) : super(<String, Map>{});

  Future<List> _updateCategoryData(String categoryToFetch) async {
    try {
      var response = await fetchFromApiUrlPath(categoryToFetch);
      var repository = jsonDecode(response.body);
      if (state.containsKey(categoryToFetch)) {
        state = state.map((category, value) {
          if (category == categoryToFetch)
            return MapEntry(category, {
              'repository': convertToList(repository),
              'updatedOn': DateTime.now()
            });
          else
            return MapEntry(category, value);
        });
      } else {
        Map<String, Map> tempMap = state.map((key, value) {
          return MapEntry(key, value);
        });
        tempMap[categoryToFetch] = {
          'repository': convertToList(repository),
          'updatedOn': DateTime.now()
        };
        state = tempMap;
      }
      return convertToList(repository);
    } catch (e) {
      return [];
    }
  }

  Future fetchPageData() async {
    String currentCategory = providerRef.read(categoryProvider).state;
    if (state[currentCategory] != null &&
        state[currentCategory]?['updatedOn'] != null) {
      var updatedOn = state[currentCategory]!['updatedOn'];
      var fiveMinutesAgo = DateTime.now().subtract(Duration(minutes: 5));
      bool isOlderThanFiveMinutes = updatedOn.isBefore(fiveMinutesAgo);
      if (isOlderThanFiveMinutes) {
        return await _updateCategoryData(currentCategory);
      } else
        return state[currentCategory]?['repository'];
    } else {
      return await _updateCategoryData(currentCategory);
    }
  }

  Future<void> refreshIndicatorFetch(String category) async {
    await _updateCategoryData(category);
    providerRef.read(rebuildProvider).state = DateTime.now().toString();
    return;
  }

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
}
