import 'dart:ui';

class Article {
  final int id;
  final String articleId;
  final String articleBody;
  final Map articleCover;
  final String coverDescription;
  final Map category;
  final String photoAuthor;
  final String textAuthor;
  final String title;
  final List tagsCollection;
  final String categoryLink;
  final List galleries;

  Article({
    this.id = 0,
    this.articleId = '',
    this.articleBody = '',
    this.articleCover = const {},
    this.category = const {},
    this.categoryLink = '',
    this.coverDescription = '',
    this.galleries = const [],
    this.photoAuthor = '',
    this.tagsCollection = const [],
    this.textAuthor = '',
    this.title = '',
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      articleId: json['articleId'] as String,
      articleBody: json['articleBody'] as String,
      articleCover: json['articleCover'] as Map<String, dynamic>,
      coverDescription: json['coverDescription'] as String,
      category: json['category'] as Map<String, dynamic>,
      photoAuthor: json['photoAuthor'] is String ? json['photoAuthor'] : '',
      textAuthor: json['textAuthor'] is String ? json['textAuthor'] : '',
      title: json['title'] as String,
      tagsCollection:
          json['tagsCollection'] is List<dynamic> ? json['tagsCollection'] : [],
      categoryLink: "/categories/${json['category']['slug'] as String}",
      galleries: json['galleries'] is List<dynamic> ? json['galleries'] : [],
    );
  }

  @override
  bool operator ==(other) {
    return (other is Article) &&
        id == other.id &&
        articleBody == other.articleBody &&
        articleCover == other.articleCover &&
        coverDescription == other.coverDescription &&
        category == other.category &&
        photoAuthor == other.photoAuthor &&
        textAuthor == other.textAuthor &&
        title == other.title &&
        tagsCollection == other.tagsCollection &&
        categoryLink == other.categoryLink &&
        galleries == other.galleries;
  }

  @override
  int get hashCode => hashValues(
      id,
      articleBody,
      articleCover,
      coverDescription,
      category,
      photoAuthor,
      textAuthor,
      title,
      tagsCollection,
      categoryLink,
      galleries);
}
