class Blog {
  final String id;
  final String title;
  final String imageUrl;
  bool isFavorite;

  Blog({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isFavorite = false,
  });

  String get getId => id;

  String get getTitle => title;

  String get getImageUrl => imageUrl;
}
