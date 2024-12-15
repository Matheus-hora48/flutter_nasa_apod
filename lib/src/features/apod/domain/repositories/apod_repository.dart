import 'package:dartz/dartz.dart';
import 'package:flutter_nasa_apod/src/core/erros/failures.dart';

import '../entities/apod.dart';

abstract class ApodRepository {
  Future<Either<Failure, Apod>> getApodByDate(DateTime date);
  Future<Either<Failure, void>> saveFavorite(Apod apod);
  Future<Either<Failure, void>> removeFavorite(Apod apod);
  Future<Either<Failure, List<Apod>>> getFavorites();
  Future<Either<Failure, bool>> isFavorite(Apod apod);
}
