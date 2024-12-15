import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/bloc/apod/apod_bloc.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/widgets/custom_erro_widget.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/widgets/favorite_item.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/widgets/loading_indicator.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (context.mounted) {
        context.read<ApodBloc>().add(GetFavoritesEvent());
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: BlocBuilder<ApodBloc, ApodState>(
        builder: (context, state) {
          if (state is ApodFavoritesLoaded) {
            return FavoriteItem(
              favorites: state.favorites,
            );
          } else if (state is ApodError) {
            return CustomErroWidget(
              message: state.message,
            );
          } else {
            return const LoadingIndicator();
          }
        },
      ),
    );
  }
}
