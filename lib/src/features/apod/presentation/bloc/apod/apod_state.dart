part of 'apod_bloc.dart';

abstract class ApodState extends Equatable {
  const ApodState();

  @override
  List<Object?> get props => [];
}

class ApodInitial extends ApodState {}

class ApodLoading extends ApodState {}

class ApodLoaded extends ApodState {
  final Apod apod;

  const ApodLoaded({required this.apod});

  @override
  List<Object?> get props => [apod];
}

class ApodFavoritesLoaded extends ApodState {
  final List<Apod> favorites;

  const ApodFavoritesLoaded({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}

class ApodError extends ApodState {
  final String message;

  const ApodError({required this.message});

  @override
  List<Object?> get props => [message];
}

