import 'package:dartz/dartz.dart';
import 'package:flutter_nasa_apod/src/core/erros/failures.dart';

import '../entities/apod.dart';
import '../repositories/apod_repository.dart';


class GetApodByDate {
  final ApodRepository repository;

  GetApodByDate(this.repository);

  Future<Either<Failure, Apod>> call(DateTime date) async {
    return await repository.getApodByDate(date);
  }
}