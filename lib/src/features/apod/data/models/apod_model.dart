import '../../domain/entities/apod.dart';

class ApodModel extends Apod {
  const ApodModel({
    required super.title,
    required super.date,
    required super.description,
    required super.mediaType,
    required super.url,
    required super.isFavorite,
  });

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
      title: json['title'],
      date: DateTime.parse(json['date']),
      description: json['explanation'],
      mediaType: json['media_type'],
      url: json['url'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'explanation': description,
      'media_type': mediaType,
      'url': url,
      'isFavorite': isFavorite,
    };
  }

  factory ApodModel.fromEntity(Apod entity) {
    return ApodModel(
      title: entity.title,
      date: entity.date,
      description: entity.description,
      mediaType: entity.mediaType,
      url: entity.url,
      isFavorite: entity.isFavorite,
    );
  }

  @override
  ApodModel copyWith({
    String? title,
    DateTime? date,
    String? description,
    String? mediaType,
    String? url,
    bool? isFavorite,
  }) {
    return ApodModel(
      title: title ?? this.title,
      date: date ?? this.date,
      description: description ?? this.description,
      mediaType: mediaType ?? this.mediaType,
      url: url ?? this.url,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ApodModel) return false;
    return title == other.title &&
        date == other.date &&
        description == other.description &&
        mediaType == other.mediaType &&
        url == other.url &&
        isFavorite == other.isFavorite;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        date.hashCode ^
        description.hashCode ^
        mediaType.hashCode ^
        url.hashCode ^
        isFavorite.hashCode;
  }

  @override
  String toString() {
    return 'ApodModel(title: $title, date: $date, description: $description, mediaType: $mediaType, url: $url, isFavorite: $isFavorite)';
  }
}
