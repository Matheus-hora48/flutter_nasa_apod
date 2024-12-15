part of 'apod_bloc.dart';

abstract class ApodEvent extends Equatable {
  const ApodEvent();

  @override
  List<Object?> get props => [];
}

class GetApodEvent extends ApodEvent {
  final DateTime? date;

  const GetApodEvent({this.date});

  @override
  List<Object?> get props => [date];
}

class SaveFavoriteEvent extends ApodEvent {
  final Apod apod;

  const SaveFavoriteEvent({required this.apod});

  @override
  List<Object?> get props => [apod];
}

class RemoveFavoriteEvent extends ApodEvent {
  final Apod apod;

  const RemoveFavoriteEvent({required this.apod});

  @override
  List<Object?> get props => [apod];
}

class GetFavoritesEvent extends ApodEvent {}

class ApodFavoriteChecked extends ApodState {
  final bool isFavorite;

  const ApodFavoriteChecked({required this.isFavorite});

  @override
  List<Object?> get props => [isFavorite];
}
