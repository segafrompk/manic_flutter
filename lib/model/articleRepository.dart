import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manic_flutter/helper/urlRequest.dart';
import 'package:manic_flutter/providers/providers.dart';
import '../helper/convert.dart';

// TODO: Razdvoji provider za trenutnu kategoriju od baze za sve kategorije
// kojima je pristupano

class ArticleRepository extends StateNotifier<Map<String, Map>> {
  ProviderReference providerRef;
  ArticleRepository(this.providerRef) : super(<String, Map>{});

  Future<List> _updateCategoryData(
      String categoryToFetch, int pageNumber) async {
    try {
      var response = categoryToFetch == 'homepage'
          ? await fetchFromApiUrlPath(categoryToFetch)
          : await fetchFromApiUrlPath(categoryToFetch,
              parameters: {'page': '$pageNumber'});
      var repository = jsonDecode(response.body);
      if (state.containsKey(categoryToFetch)) {
        state = state.map((category, value) {
          if (category == categoryToFetch) {
            if (pageNumber <= value['lastPageLoaded'] && pageNumber != 1) {
              return MapEntry(category, value);
            }
            providerRef.read(rebuildProvider).state = DateTime.now().toString();

            return MapEntry(category, {
              'repository': (pageNumber == 1 || category == 'homepage')
                  ? convertToList(repository)
                  : [...value['repository'], ...convertToList(repository)],
              'lastPageLoaded': pageNumber,
              'updatedOn': DateTime.now()
            });
          } else
            return MapEntry(category, value);
        });
      } else {
        Map<String, Map> tempMap = state.map((key, value) {
          return MapEntry(key, value);
        });
        tempMap[categoryToFetch] = {
          'repository': convertToList(repository),
          'lastPageLoaded': pageNumber,
          'updatedOn': DateTime.now()
        };
        providerRef.read(rebuildProvider).state = DateTime.now().toString();

        state = tempMap;
      }
      updateCurrentCategoryRepository({
        'articleData': state[categoryToFetch]!['repository'],
        'availablePagesNumber': 1
      });
      return state.containsKey(categoryToFetch)
          ? state[categoryToFetch]!['repository']
          : [];
    } catch (e) {
      return [];
    }
  }

  int getNumberOfPagesLoaded(String currentCategory) {
    return state[currentCategory] != null
        ? state[currentCategory]!['lastPageLoaded']
        : 1;
  }

  Future fetchPageData({int pageNumber = 1}) async {
    String currentCategory = providerRef.read(categoryProvider).state;
    if (state[currentCategory] != null &&
        state[currentCategory]!['updatedOn'] != null) {
      var updatedOn = state[currentCategory]!['updatedOn'];
      var fiveMinutesAgo = DateTime.now().subtract(Duration(minutes: 5));
      bool isOlderThanFiveMinutes = updatedOn.isBefore(fiveMinutesAgo);
      if (isOlderThanFiveMinutes) {
        return await _updateCategoryData(currentCategory, pageNumber);
      } else
        updateCurrentCategoryRepository({
          'articleData': state[currentCategory]!['repository'],
          'availablePagesNumber': 1
        });
      return state[currentCategory]!['repository'];
    } else {
      return await _updateCategoryData(currentCategory, pageNumber);
    }
  }

  Future<void> refreshIndicatorFetch(String category) async {
    await _updateCategoryData(category, 1);
    return;
  }

  Future<void> loadMoreArticles(String category, int pageNumber) async {
    await _updateCategoryData(category, pageNumber);
    return;
  }

  void updateCurrentCategoryRepository(data) {
    providerRef
        .read(currentCategoryRepository.notifier)
        .updateCurrentCategory(data);
  }
}
