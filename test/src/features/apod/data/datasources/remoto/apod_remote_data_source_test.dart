import 'package:dio/dio.dart';
import 'package:flutter_nasa_apod/src/core/erros/failures.dart';
import 'package:flutter_nasa_apod/src/features/apod/data/datasources/remote/apod_remote_data_source.dart';
import 'package:flutter_nasa_apod/src/features/apod/data/models/apod_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'apod_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final client = MockDio();
  final source = ApodRemoteDataSourceImpl(client);

  group('getApodByDate', () {
    final date = DateTime(2024, 12, 12);
    final apiResponse = {
      "title": "Example title",
      "date": date.toIso8601String(),
      "explanation": "Example explanation",
      "url": "https://example.com/image.jpg",
      "media_type": "image"
    };

    test('deve retornar ApodModel quando a chamada da API for bem-sucedida',
        () async {
      when(client.get(
        'https://api.nasa.gov/planetary/apod',
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          data: apiResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/'),
        ),
      );

      final result = await source.getApodByDate(date);

      expect(result, isA<ApodModel>());
      expect(result.date, date);
      expect(result.description, 'Example explanation');
    });

    test(
      'deve lançar ServerFailure quando a chamada da API não for bem-sucedida',
      () async {
        final date = DateTime(2224, 12, 12);

        final dioError = DioException(
          response: Response(
            data: {},
            statusCode: 500,
            requestOptions: RequestOptions(path: '/'),
          ),
          requestOptions: RequestOptions(path: '/'),
          type: DioExceptionType.badResponse,
        );

        when(client.get(
          any,
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        )).thenThrow(dioError);

        expect(
          () async => await source.getApodByDate(date),
          throwsA(
            predicate<ServerFailure>(
              (failure) => failure.message.contains('Erro ao conectar à API'),
            ),
          ),
        );
      },
    );
  });
}
