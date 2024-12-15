import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/bloc/apod/apod_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_nasa_apod/src/core/erros/failures.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/entities/apod.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/usecases/get_apod_by_date.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/usecases/manage_favorites.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'apod_bloc_test.mocks.dart';

@GenerateMocks([GetApodByDate, GetFavorites, SaveFavorite, RemoveFavorite])
void main() {
  late MockGetApodByDate mockGetApodByDate;
  late MockGetFavorites mockGetFavorites;
  late MockSaveFavorite mockSaveFavorite;
  late MockRemoveFavorite mockRemoveFavorite;
  late ApodBloc apodBloc;

  setUp(() {
    mockGetApodByDate = MockGetApodByDate();
    mockGetFavorites = MockGetFavorites();
    mockSaveFavorite = MockSaveFavorite();
    mockRemoveFavorite = MockRemoveFavorite();
    apodBloc = ApodBloc(
      getApodByDate: mockGetApodByDate,
      getFavorites: mockGetFavorites,
      saveFavorite: mockSaveFavorite,
      removeFavorite: mockRemoveFavorite,
    );
  });

  final tDate = DateTime(2022, 1, 1);

  var tApod = Apod(
    title: 'Test Title',
    date: tDate,
    mediaType: 'image',
    url: 'https://test.com/image.jpg',
    description: 'Test Explanation',
    isFavorite: false,
  );

  tearDown(() {
    apodBloc.close();
  });

  group('GetApodEvent', () {
    blocTest<ApodBloc, ApodState>(
      'emite [ApodLoading, ApodLoaded] quando getApodByDate é bem-sucedido',
      build: () {
        when(mockGetApodByDate.call(tDate))
            .thenAnswer((_) async => Right(tApod));
        return apodBloc;
      },
      act: (bloc) => bloc.add(GetApodEvent(date: tDate)),
      expect: () => [
        ApodLoading(),
        ApodLoaded(apod: tApod),
      ],
    );

    blocTest<ApodBloc, ApodState>(
      'emite [ApodLoading, ApodError] quando getApodByDate falha',
      build: () {
        when(mockGetApodByDate.call(tDate))
            .thenAnswer((_) async => const Left(ServerFailure('')));
        return apodBloc;
      },
      act: (bloc) => bloc.add(GetApodEvent(date: tDate)),
      expect: () => [
        ApodLoading(),
        const ApodError(message: 'Server Failure'),
      ],
    );
  });

  group('SaveFavoriteEvent', () {
    blocTest<ApodBloc, ApodState>(
      'emite [ApodError] quando saveFavorite falha',
      build: () {
        when(mockSaveFavorite.call(tApod))
            .thenAnswer((_) async => const Left(CacheFailure('')));
        return apodBloc;
      },
      act: (bloc) => bloc.add(SaveFavoriteEvent(apod: tApod)),
      expect: () => [
        const ApodError(message: 'Cache Failure'),
      ],
    );
  });

  group('RemoveFavoriteEvent', () {
    blocTest<ApodBloc, ApodState>(
      'emite [ApodError] quando removeFavorite falha',
      build: () {
        when(mockRemoveFavorite.call(tApod))
            .thenAnswer((_) async => const Left(CacheFailure('')));
        return apodBloc;
      },
      act: (bloc) => bloc.add(RemoveFavoriteEvent(apod: tApod)),
      expect: () => [
        const ApodError(message: 'Cache Failure'),
      ],
    );
  });

  group('GetFavoritesEvent', () {
    blocTest<ApodBloc, ApodState>(
      'emite [ApodLoading, ApodFavoritesLoaded] quando getFavorites é bem-sucedido',
      build: () {
        when(mockGetFavorites.call()).thenAnswer((_) async => Right([tApod]));
        return apodBloc;
      },
      act: (bloc) => bloc.add(GetFavoritesEvent()),
      expect: () => [
        ApodLoading(),
        ApodFavoritesLoaded(favorites: [tApod]),
      ],
    );

    blocTest<ApodBloc, ApodState>(
      'emite [ApodLoading, ApodError] quando getFavorites falha',
      build: () {
        when(mockGetFavorites.call())
            .thenAnswer((_) async => const Left(CacheFailure('Cache Failure')));
        return apodBloc;
      },
      act: (bloc) => bloc.add(GetFavoritesEvent()),
      expect: () => [
        ApodLoading(),
        const ApodError(message: 'Cache Failure'),
      ],
    );
  });
}
