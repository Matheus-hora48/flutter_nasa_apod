import 'package:flutter_nasa_apod/src/core/erros/failures.dart';
import 'package:flutter_nasa_apod/src/features/apod/data/datasources/local/apod_local_data_source.dart';
import 'package:flutter_nasa_apod/src/features/apod/data/datasources/remote/apod_remote_data_source.dart';
import 'package:flutter_nasa_apod/src/features/apod/data/models/apod_model.dart';
import 'package:flutter_nasa_apod/src/features/apod/data/repositories/apod_repository_impl.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/entities/apod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import 'apod_repository_impl_test.mocks.dart';

@GenerateMocks([ApodRemoteDataSource, ApodLocalDataSource])
void main() {
  late ApodRepositoryImpl repository;
  late MockApodRemoteDataSource mockRemoteDataSource;
  late MockApodLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockApodRemoteDataSource();
    mockLocalDataSource = MockApodLocalDataSource();
    repository = ApodRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('getApod', () {
    final tDate = DateTime(2022, 10, 10);
    final tApodModel = ApodModel(
      title: 'Test Title',
      date: tDate,
      description: 'Test Description',
      mediaType: 'image',
      url: 'https://testurl.com/image.jpg',
      isFavorite: false,
    );
    final Apod tApod = tApodModel;

    test(
        'deve retornar dados remotos quando a chamada para a fonte de dados remota for bem-sucedida',
        () async {
      when(mockRemoteDataSource.getApodByDate(tDate))
          .thenAnswer((_) async => tApodModel);
      when(mockLocalDataSource.isFavorite(any)).thenAnswer((_) async => false);

      final result = await repository.getApodByDate(tDate);

      verify(mockRemoteDataSource.getApodByDate(tDate));
      expect(result, Right(tApod));
    });

    test(
        'deve retornar ServerFailure quando a chamada para a fonte de dados remota não for bem-sucedida',
        () async {
      when(mockRemoteDataSource.getApodByDate(tDate))
          .thenThrow(const ServerFailure('Erro ao buscar o apod'));

      final result = await repository.getApodByDate(tDate);

      verify(mockRemoteDataSource.getApodByDate(tDate));
      expect(result, const Left(ServerFailure('Erro ao buscar o apod')));
    });
  });

  group('getFavorites', () {
    final tApodModelList = [
      ApodModel(
        title: 'Test Title',
        date: DateTime(2022, 10, 10),
        description: 'Test Description',
        mediaType: 'image',
        url: 'https://testurl.com/image.jpg',
        isFavorite: false,
      ),
    ];
    final List<Apod> tApodList = tApodModelList;

    test('deve retornar lista de favoritos da fonte de dados local', () async {
      when(mockLocalDataSource.getFavorites())
          .thenAnswer((_) async => tApodModelList);

      final result = await repository.getFavorites();

      verify(mockLocalDataSource.getFavorites());
      expect(result, Right(tApodList));
    });
  });

  group('saveFavorite', () {
    final tApod = Apod(
      title: 'Test Title',
      date: DateTime(2022, 10, 10),
      description: 'Test Description',
      mediaType: 'image',
      url: 'https://testurl.com/image.jpg',
      isFavorite: false,
    );

    test('deve chamar a fonte de dados local para salvar os favoritos',
        () async {
      when(mockLocalDataSource.saveFavorite(any)).thenAnswer((_) async => {});

      final result = await repository.saveFavorite(tApod);

      verify(mockLocalDataSource.saveFavorite(any));
      expect(result, const Right(null));
    });
  });

  group('removeFavorite', () {
    final tApod = Apod(
      title: 'Test Title',
      date: DateTime(2022, 10, 10),
      description: 'Test Description',
      mediaType: 'image',
      url: 'https://testurl.com/image.jpg',
      isFavorite: false,
    );

    test('deve chamar a fonte de dados local para remover o favorito',
        () async {
      when(mockLocalDataSource.removeFavorite(any)).thenAnswer((_) async => {});

      final result = await repository.removeFavorite(tApod);

      verify(mockLocalDataSource.removeFavorite(any));
      expect(result, const Right(null));
    });
  });

  group('isFavorite', () {
    final tApod = Apod(
      title: 'Test Title',
      date: DateTime(2022, 10, 10),
      description: 'Test Description',
      mediaType: 'image',
      url: 'https://testurl.com/image.jpg',
      isFavorite: false,
    );

    test('deve retornar verdadeiro quando o apod for um favorito', () async {
      final apodModel = ApodModel.fromEntity(tApod);
      when(mockLocalDataSource.isFavorite(apodModel))
          .thenAnswer((_) async => true);

      final result = await repository.isFavorite(tApod);

      verify(mockLocalDataSource.isFavorite(apodModel));
      expect(result, const Right(true));
    });

    test('deve retornar falso quando o apod não for um favorito', () async {
      final apodModel = ApodModel.fromEntity(tApod);
      when(mockLocalDataSource.isFavorite(apodModel))
          .thenAnswer((_) async => false);

      final result = await repository.isFavorite(tApod);

      verify(mockLocalDataSource.isFavorite(apodModel));
      expect(result, const Right(false));
    });
  });
}
