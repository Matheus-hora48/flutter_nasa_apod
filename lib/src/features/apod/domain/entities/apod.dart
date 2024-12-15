class Apod {
  final String title;
  final DateTime date;
  final String description;
  final String mediaType;
  final String url;
  final bool isFavorite;

  const Apod({
    required this.title,
    required this.date,
    required this.description,
    required this.mediaType,
    required this.url,
    required this.isFavorite,
  });

  copyWith({required bool isFavorite}) {}
}
