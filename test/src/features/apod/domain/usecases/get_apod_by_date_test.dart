import 'package:flutter_nasa_apod/src/core/erros/failures.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/entities/apod.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/repositories/apod_repository.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/usecases/get_apod_by_date.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'get_apod_by_date_test.mocks.dart';

@GenerateMocks([ApodRepository])
void main() {
  late GetApodByDate useCase;
  late MockApodRepository mockRepository;

  setUp(() {
    mockRepository = MockApodRepository();
    useCase = GetApodByDate(mockRepository);
  });

  group('GetApodByDate', () {
    final tDate = DateTime(2022, 10, 10);
    final tApod = Apod(
      title: 'Test Title',
      date: tDate,
      description: 'Test Description',
      mediaType: 'image',
      url: 'https://testurl.com/image.jpg',
      isFavorite: false,
    );

    test(
        'deve retornar o Apod quando a chamada ao repositório for bem-sucedida',
        () async {
      when(mockRepository.getApodByDate(tDate))
          .thenAnswer((_) async => Right(tApod));

      final result = await useCase(tDate);

      verify(mockRepository.getApodByDate(tDate));
      expect(result, Right(tApod));
    });

    test(
        'deve retornar ServerFailure quando a chamada para o repositório falhar',
        () async {
      when(mockRepository.getApodByDate(tDate)).thenAnswer(
          (_) async => const Left(ServerFailure('Error fetching Apod')));

      final result = await useCase(tDate);

      verify(mockRepository.getApodByDate(tDate));
      expect(result, const Left(ServerFailure('Error fetching Apod')));
    });
  });
}
