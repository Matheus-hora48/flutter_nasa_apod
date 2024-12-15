import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_nasa_apod/src/core/erros/failures.dart';

import '../../models/apod_model.dart';

abstract class ApodRemoteDataSource {
  Future<ApodModel> getApodByDate(DateTime date);
}

class ApodRemoteDataSourceImpl implements ApodRemoteDataSource {
  final Dio dio;

  ApodRemoteDataSourceImpl(this.dio);

  @override
  Future<ApodModel> getApodByDate(DateTime date) async {
    try {
      final response = await dio.get(
        'https://api.nasa.gov/planetary/apod',
        queryParameters: {
          'api_key': 'cu3bmeafyOYB9R7gycRI98fzVhzizgTI6qRdvmpj',
          'date': date.toIso8601String().split('T').first,
        },
      );

      if (response.statusCode == 200) {
        return ApodModel.fromJson(response.data);
      } else {
        throw const ServerFailure('Failed to fetch APOD');
      }
    } on DioException catch (e, s) {
      log(
        'Erro ao conectar à API: ${e.response?.statusCode}',
        error: e,
        stackTrace: s,
      );
      throw ServerFailure('Erro ao conectar à API: ${e.response?.statusCode}');
    }
  }
}
