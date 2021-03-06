import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manic_flutter/model/articleRepository.dart';
import 'package:manic_flutter/providers/currentCategoryRepository.dart';

final categoryProvider = StateProvider<String>((ref) => 'homepage');

final rebuildProvider =
    StateProvider<String>((ref) => DateTime.now().toString());

final articleRepositoryProvider =
    StateNotifierProvider((ref) => ArticleRepository(ref));

final currentCategoryRepository =
    StateNotifierProvider((ref) => CurrentCategoryRepository(ref));
