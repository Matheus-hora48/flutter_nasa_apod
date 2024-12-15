import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../data/datasources/local/apod_local_data_source.dart';
import '../data/datasources/remote/apod_remote_data_source.dart';
import '../data/repositories/apod_repository_impl.dart';
import '../domain/repositories/apod_repository.dart';
import '../domain/usecases/get_apod_by_date.dart';
import '../domain/usecases/manage_favorites.dart';
import 'bloc/apod/apod_bloc.dart';
import 'favorites_route.dart';
import 'home_route.dart';

class ApodModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<ApodLocalDataSource>(
          (i) => ApodLocalDataSourceImpl(),
        ),
        Bind.lazySingleton<ApodRemoteDataSource>(
          (i) => ApodRemoteDataSourceImpl(Dio()),
        ),
        Bind.lazySingleton<ApodRepository>(
          (i) => ApodRepositoryImpl(
            localDataSource: i(),
            remoteDataSource: i(),
          ),
        ),
        Bind.lazySingleton((i) => GetApodByDate(i())),
        Bind.lazySingleton((i) => SaveFavorite(i())),
        Bind.lazySingleton((i) => RemoveFavorite(i())),
        Bind.lazySingleton((i) => GetFavorites(i())),
        Bind.lazySingleton((i) => CheckFavorite(i())),
        Bind.factory((i) => ApodBloc(
              getApodByDate: i(),
              getFavorites: i(),
              saveFavorite: i(),
              removeFavorite: i(),
            )),
      ];

  @override
  String get moduleRouteName => '/';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const HomeRoute(),
        '/favorites': (context) => const FavoritesRoute(),
      };
}
