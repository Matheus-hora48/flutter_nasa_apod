import 'package:dartz/dartz.dart';
import 'package:flutter_nasa_apod/src/core/erros/failures.dart';

import '../../domain/entities/apod.dart';
import '../../domain/repositories/apod_repository.dart';
import '../datasources/local/apod_local_data_source.dart';
import '../datasources/remote/apod_remote_data_source.dart';
import '../models/apod_model.dart';

class ApodRepositoryImpl implements ApodRepository {
  final ApodRemoteDataSource remoteDataSource;
  final ApodLocalDataSource localDataSource;

  ApodRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<ServerFailure, Apod>> getApodByDate(DateTime date) async {
    try {
      final remoteApod = await remoteDataSource.getApodByDate(date);
      final isFavorite = await localDataSource.isFavorite(remoteApod);
      return Right(remoteApod.copyWith(isFavorite: isFavorite));
    } on ServerFailure {
      return const Left(ServerFailure('Erro ao buscar o apod'));
    }
  }

  @override
  Future<Either<CacheFailure, List<Apod>>> getFavorites() async {
    try {
      final favorites = await localDataSource.getFavorites();
      return Right(favorites);
    } catch (e) {
      return Left(CacheFailure('Erro ao obter favoritos: $e'));
    }
  }

  @override
  Future<Either<CacheFailure, void>> saveFavorite(Apod apod) async {
    try {
      final apodModel = ApodModel.fromEntity(apod);
      await localDataSource.saveFavorite(apodModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Erro ao salvar favorito: $e'));
    }
  }

  @override
  Future<Either<CacheFailure, void>> removeFavorite(Apod apod) async {
    try {
      final apodModel = ApodModel.fromEntity(apod);
      await localDataSource.removeFavorite(apodModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Erro ao remover favorito: $e'));
    }
  }

  @override
  Future<Either<CacheFailure, bool>> isFavorite(Apod apod) async {
    try {
      final apodModel = ApodModel.fromEntity(apod);
      final isFavorite = await localDataSource.isFavorite(apodModel);
      return Right(isFavorite);
    } catch (e) {
      return Left(CacheFailure('Erro ao verificar se é favorito: $e'));
    }
  }
}
