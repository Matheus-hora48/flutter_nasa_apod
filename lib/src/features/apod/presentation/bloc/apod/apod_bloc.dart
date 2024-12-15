import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_nasa_apod/src/core/erros/failures.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/usecases/get_apod_by_date.dart';

import '../../../domain/entities/apod.dart';
import '../../../domain/usecases/manage_favorites.dart';

part 'apod_event.dart';
part 'apod_state.dart';

class ApodBloc extends Bloc<ApodEvent, ApodState> {
  final GetApodByDate getApodByDate;
  final GetFavorites getFavorites;
  final SaveFavorite saveFavorite;
  final RemoveFavorite removeFavorite;

  ApodBloc({
    required this.getApodByDate,
    required this.getFavorites,
    required this.saveFavorite,
    required this.removeFavorite,
  }) : super(ApodInitial()) {
    on<GetApodEvent>(_onGetApod);
    on<SaveFavoriteEvent>(_onSaveFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
    on<GetFavoritesEvent>(_onGetFavorites);
  }

  Future<void> _onGetApod(
    GetApodEvent event,
    Emitter<ApodState> emit,
  ) async {
    emit(ApodLoading());
    final result = await getApodByDate(event.date!);
    result.fold(
      (failure) => emit(ApodError(message: _mapFailureToMessage(failure))),
      (apod) => emit(ApodLoaded(apod: apod)),
    );
  }

  Future<void> _onSaveFavorite(
    SaveFavoriteEvent event,
    Emitter<ApodState> emit,
  ) async {
    final result = await saveFavorite(event.apod);
    result.fold(
      (failure) => emit(ApodError(message: _mapFailureToMessage(failure))),
      (_) => add(GetApodEvent(date: event.apod.date)),
    );
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteEvent event,
    Emitter<ApodState> emit,
  ) async {
    final result = await removeFavorite(event.apod);
    result.fold(
      (failure) => emit(ApodError(message: _mapFailureToMessage(failure))),
      (_) => add(GetApodEvent(date: event.apod.date)),
    );
  }

  Future<void> _onGetFavorites(
    GetFavoritesEvent event,
    Emitter<ApodState> emit,
  ) async {
    emit(ApodLoading());
    final result = await getFavorites();
    result.fold(
      (failure) => emit(ApodError(message: _mapFailureToMessage(failure))),
      (favorites) => emit(ApodFavoritesLoaded(favorites: favorites)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Não foi possível buscar os dados da API. Verifique sua conexão com a internet.';
    } else if (failure is CacheFailure) {
      return 'Não foi possível carregar os dados do cache local. Tente novamente mais tarde.';
    } else {
      return 'Ocorreu um erro inesperado. Tente novamente.';
    }
  }
}
