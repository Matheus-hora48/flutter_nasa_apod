import 'package:dartz/dartz.dart';
import 'package:flutter_nasa_apod/src/core/erros/failures.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/repositories/apod_repository.dart';

import '../entities/apod.dart';

class SaveFavorite {
  final ApodRepository repository;

  SaveFavorite(this.repository);

  Future<Either<Failure, void>> call(Apod apod) async {
    return await repository.saveFavorite(apod);
  }
}

class RemoveFavorite {
  final ApodRepository repository;

  RemoveFavorite(this.repository);

  Future<Either<Failure, void>> call(Apod apod) async {
    return await repository.removeFavorite(apod);
  }
}

class GetFavorites {
  final ApodRepository repository;

  GetFavorites(this.repository);

  Future<Either<Failure, List<Apod>>> call() async {
    return await repository.getFavorites();
  }
}

class CheckFavorite {
  final ApodRepository repository;

  CheckFavorite(this.repository);

  Future<Either<Failure, bool>> call(Apod apod) async {
    return await repository.isFavorite(apod);
  }
}
