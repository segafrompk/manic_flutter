import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:manic_flutter/providers/providers.dart';

class CurrentCategoryRepository extends StateNotifier<Map<String, dynamic>> {
  ProviderReference providerRef;

  CurrentCategoryRepository(this.providerRef)
      : super(<String, dynamic>{'articleData': [], 'availablePagesNumber': 1});

  void updateCurrentCategory(dataToUpdate) {
    state = dataToUpdate;
  }
}
