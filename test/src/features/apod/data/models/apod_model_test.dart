import 'package:flutter_nasa_apod/src/features/apod/data/models/apod_model.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/entities/apod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApodModel', () {
    test('fromJson deve criar um ApodModel a partir de um objeto JSON', () {
      final json = {
        'title': 'Astronomy Picture of the Day',
        'date': '2024-12-13T00:00:00Z',
        'explanation': 'A beautiful view of the stars.',
        'media_type': 'image',
        'url': 'https://example.com/apod.jpg',
      };

      final apodModel = ApodModel.fromJson(json);

      expect(apodModel.title, 'Astronomy Picture of the Day');
      expect(apodModel.date, DateTime.parse('2024-12-13T00:00:00Z'));
      expect(apodModel.description, 'A beautiful view of the stars.');
      expect(apodModel.mediaType, 'image');
      expect(apodModel.url, 'https://example.com/apod.jpg');
    });

    test('toJson deve converter um ApodModel em um objeto JSON', () {
      final apodModel = ApodModel(
        title: 'Astronomy Picture of the Day',
        date: DateTime(2024, 12, 13),
        description: 'A beautiful view of the stars.',
        mediaType: 'image',
        url: 'https://example.com/apod.jpg',
        isFavorite: false,
      );

      final json = apodModel.toJson();

      expect(json['title'], 'Astronomy Picture of the Day');
      expect(json['date'], '2024-12-13T00:00:00.000');
      expect(json['explanation'], 'A beautiful view of the stars.');
      expect(json['media_type'], 'image');
      expect(json['url'], 'https://example.com/apod.jpg');
    });

    test('fromEntity deve criar um ApodModel a partir de uma entidade Apod',
        () {
      final apodEntity = Apod(
        title: 'Astronomy Picture of the Day',
        date: DateTime(2024, 12, 13),
        description: 'A beautiful view of the stars.',
        mediaType: 'image',
        url: 'https://example.com/apod.jpg',
        isFavorite: false,
      );

      final apodModel = ApodModel.fromEntity(apodEntity);

      expect(apodModel.title, 'Astronomy Picture of the Day');
      expect(apodModel.date, DateTime(2024, 12, 13));
      expect(apodModel.description, 'A beautiful view of the stars.');
      expect(apodModel.mediaType, 'image');
      expect(apodModel.url, 'https://example.com/apod.jpg');
    });

    test(
        'fromEntity shouApodModel deve ser igual se todos os campos forem iguais, crie um ApodModel a partir de uma entidade Apod',
        () {
      final apod1 = ApodModel(
        title: 'Astronomy Picture of the Day',
        date: DateTime(2024, 12, 13),
        description: 'A beautiful view of the stars.',
        mediaType: 'image',
        url: 'https://example.com/apod.jpg',
        isFavorite: false,
      );

      final apod2 = ApodModel(
        title: 'Astronomy Picture of the Day',
        date: DateTime(2024, 12, 13),
        description: 'A beautiful view of the stars.',
        mediaType: 'image',
        url: 'https://example.com/apod.jpg',
        isFavorite: false,
      );

      final apod3 = ApodModel(
        title: 'Another Picture of the Day',
        date: DateTime(2024, 12, 14),
        description: 'A different view of the stars.',
        mediaType: 'image',
        url: 'https://example.com/apod2.jpg',
        isFavorite: false,
      );

      expect(apod1, equals(apod2));
      expect(apod1, isNot(equals(apod3)));
    });

    test('ApodModel deve ter o hashCode correto', () {
      final apod1 = ApodModel(
        title: 'Astronomy Picture of the Day',
        date: DateTime(2024, 12, 13),
        description: 'A beautiful view of the stars.',
        mediaType: 'image',
        url: 'https://example.com/apod.jpg',
        isFavorite: false,
      );

      final apod2 = ApodModel(
        title: 'Astronomy Picture of the Day',
        date: DateTime(2024, 12, 13),
        description: 'A beautiful view of the stars.',
        mediaType: 'image',
        url: 'https://example.com/apod.jpg',
        isFavorite: false,
      );

      final apod3 = ApodModel(
        title: 'Another Picture of the Day',
        date: DateTime(2024, 12, 14),
        description: 'A different view of the stars.',
        mediaType: 'image',
        url: 'https://example.com/apod2.jpg',
        isFavorite: false,
      );

      expect(apod1.hashCode, equals(apod2.hashCode));
      expect(apod1.hashCode, isNot(equals(apod3.hashCode)));
    });
  });
}
