import 'package:flutter_nasa_apod/src/features/apod/domain/entities/apod.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/repositories/apod_repository.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/usecases/manage_favorites.dart';
import 'package:flutter_nasa_apod/src/core/erros/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'manage_favorites_test.mocks.dart';

@GenerateMocks([ApodRepository])
void main() {
  late SaveFavorite saveFavorite;
  late RemoveFavorite removeFavorite;
  late GetFavorites getFavorites;
  late MockApodRepository mockApodRepository;
  late Apod tApod;

  setUp(() {
    mockApodRepository = MockApodRepository();
    saveFavorite = SaveFavorite(mockApodRepository);
    removeFavorite = RemoveFavorite(mockApodRepository);
    getFavorites = GetFavorites(mockApodRepository);

    tApod = Apod(
      title: 'Test Title',
      date: DateTime(2022, 10, 10),
      description: 'Test Description',
      mediaType: 'image',
      url: 'https://testurl.com/image.jpg',
      isFavorite: false,
    );
  });

  group('SaveFavorite', () {
    test('deve chamar saveFavorite no repositório e retornar Right', () async {
      when(mockApodRepository.saveFavorite(tApod))
          .thenAnswer((_) async => const Right<Failure, void>(null));

      final result = await saveFavorite(tApod);

      expect(result, const Right<Failure, void>(null));
      verify(mockApodRepository.saveFavorite(tApod));
      verifyNoMoreInteractions(mockApodRepository);
    });

    test('deve retornar uma falha quando o salvamento falhar', () async {
      when(mockApodRepository.saveFavorite(tApod)).thenAnswer(
          (_) async => const Left<Failure, void>(ServerFailure('')));

      final result = await saveFavorite(tApod);

      expect(
          result.fold(
              (l) => l is ServerFailure && l.message == '', (r) => false),
          true);
      verify(mockApodRepository.saveFavorite(tApod));
      verifyNoMoreInteractions(mockApodRepository);
    });
  });

  group('RemoveFavorite', () {
    test('deve chamar removeFavorite no repositório e retornar Right',
        () async {
      when(mockApodRepository.removeFavorite(tApod))
          .thenAnswer((_) async => const Right<Failure, void>(null));

      final result = await removeFavorite(tApod);

      expect(result, const Right<Failure, void>(null));
      verify(mockApodRepository.removeFavorite(tApod));
      verifyNoMoreInteractions(mockApodRepository);
    });

    test('deve retornar uma falha ao remover falhas', () async {
      when(mockApodRepository.removeFavorite(tApod)).thenAnswer(
          (_) async => const Left<Failure, void>(ServerFailure('')));

      final result = await removeFavorite(tApod);

      expect(result, equals(const Left<Failure, void>(ServerFailure(''))));
      verify(mockApodRepository.removeFavorite(tApod));
      verifyNoMoreInteractions(mockApodRepository);
    });
  });

  group('GetFavorites', () {
    test('deve retornar uma falha quando o salvamento falhar', () async {
      when(mockApodRepository.saveFavorite(tApod)).thenAnswer(
          (_) async => const Left<Failure, void>(ServerFailure('')));

      final result = await saveFavorite(tApod);

      expect(
          result.fold(
              (l) => l is ServerFailure && l.message == '', (r) => false),
          true);
      verify(mockApodRepository.saveFavorite(tApod));
      verifyNoMoreInteractions(mockApodRepository);
    });

    test('deve retornar uma falha quando a recuperação de favoritos falhar',
        () async {
      when(mockApodRepository.getFavorites()).thenAnswer(
          (_) async => const Left<Failure, List<Apod>>(ServerFailure('')));

      final result = await getFavorites();

      expect(
          result, equals(const Left<Failure, List<Apod>>(ServerFailure(''))));
      verify(mockApodRepository.getFavorites());
      verifyNoMoreInteractions(mockApodRepository);
    });
  });
}
