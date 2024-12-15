
import 'package:flutter_nasa_apod/src/features/apod/data/datasources/local/apod_local_data_source.dart';
import 'package:flutter_nasa_apod/src/features/apod/data/datasources/remote/apod_remote_data_source.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/repositories/apod_repository.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/apod_module.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/bloc/apod/apod_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

void main() {
  setUpAll(() {
    ApodModule();
  });

  tearDownAll(() {
    GetIt.instance.reset();
  });

  test('test injection of ApodBloc and dependencies', () {
    final apodBloc = GetIt.instance<ApodBloc>();

    expect(apodBloc, isNotNull);

    expect(apodBloc.getApodByDate, isNotNull);
    expect(apodBloc.getFavorites, isNotNull);
    expect(apodBloc.saveFavorite, isNotNull);
    expect(apodBloc.removeFavorite, isNotNull);

    final apodRepository = GetIt.instance<ApodRepository>();
    expect(apodRepository, isNotNull);
    final apodLocalDataSource = GetIt.instance<ApodLocalDataSource>();
    expect(apodLocalDataSource, isNotNull);
    final apodRemoteDataSource = GetIt.instance<ApodRemoteDataSource>();
    expect(apodRemoteDataSource, isNotNull);
    final dio = GetIt.instance<Dio>();
    expect(dio, isNotNull);
  });
}
