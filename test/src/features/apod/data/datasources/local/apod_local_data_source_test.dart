import 'dart:convert';
import 'package:flutter_nasa_apod/src/features/apod/data/datasources/local/apod_local_data_source.dart';
import 'package:flutter_nasa_apod/src/features/apod/data/models/apod_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences sharedPreferences;
  late ApodLocalDataSourceImpl dataSource;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});

    sharedPreferences = await SharedPreferences.getInstance();
    dataSource = ApodLocalDataSourceImpl();
  });

  group('ApodLocalDataSourceImpl', () {
    final ApodModel tApodModel = ApodModel(
      title: 'Test Title',
      date: DateTime(2022, 10, 10),
      description: 'Test Description',
      mediaType: 'image',
      url: 'https://testurl.com/image.jpg',
      isFavorite: true,
    );

    test('deve salvar um favorito', () async {
      final List<ApodModel> expectedFavorites = [tApodModel];
      final jsonString =
          jsonEncode(expectedFavorites.map((e) => e.toJson()).toList());

      await dataSource.saveFavorite(tApodModel);

      final storedJsonString =
          sharedPreferences.getString(ApodLocalDataSourceImpl.favoritesKey);
      expect(storedJsonString, jsonString);
    });

    test('deve retornar a lista de favoritos de SharedPreferences', () async {
      final List<ApodModel> favoritesList = [tApodModel];
      final jsonString =
          jsonEncode(favoritesList.map((e) => e.toJson()).toList());
      sharedPreferences.setString(
          ApodLocalDataSourceImpl.favoritesKey, jsonString);

      final result = await dataSource.getFavorites();

      expect(result.length, equals(favoritesList.length));
      for (int i = 0; i < result.length; i++) {
        expect(result[i].title, equals(favoritesList[i].title));
        expect(result[i].date, equals(favoritesList[i].date));
        expect(result[i].description, equals(favoritesList[i].description));
        expect(result[i].mediaType, equals(favoritesList[i].mediaType));
        expect(result[i].url, equals(favoritesList[i].url));
      }
    });

    test('deverá retornar uma lista vazia se nenhum favorito for salvo',
        () async {
      final result = await dataSource.getFavorites();

      expect(result, []);
    });

    test('deveria remover um favorito', () async {
      final List<ApodModel> initialFavorites = [tApodModel];
      final initialJsonString =
          jsonEncode(initialFavorites.map((e) => e.toJson()).toList());
      sharedPreferences.setString(
          ApodLocalDataSourceImpl.favoritesKey, initialJsonString);

      await dataSource.removeFavorite(tApodModel);

      final updatedJsonString = jsonEncode([]);
      final storedJsonString =
          sharedPreferences.getString(ApodLocalDataSourceImpl.favoritesKey);
      expect(storedJsonString, updatedJsonString);
    });

    test('não deve remover nenhum favorito se ele não existir', () async {
      final List<ApodModel> initialFavorites = [tApodModel];
      final initialJsonString =
          jsonEncode(initialFavorites.map((e) => e.toJson()).toList());
      sharedPreferences.setString(
          ApodLocalDataSourceImpl.favoritesKey, initialJsonString);

      final ApodModel newApod = ApodModel(
        title: 'Another Test Title',
        date: DateTime(2023, 1, 1),
        description: 'Another Test Description',
        mediaType: 'image',
        url: 'https://anotherurl.com/image.jpg',
        isFavorite: true,
      );

      await dataSource.removeFavorite(newApod);

      final storedJsonString =
          sharedPreferences.getString(ApodLocalDataSourceImpl.favoritesKey);
      expect(storedJsonString, initialJsonString);
    });
  });
}
