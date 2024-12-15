import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/apod.dart';
import '../bloc/apod/apod_bloc.dart';
import '../dialogs/detail_apod_dialog.dart';

class FavoriteItem extends StatelessWidget {
  final List<Apod> favorites;

  const FavoriteItem({
    super.key,
    required this.favorites,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          Apod apod = favorites[index];
          return ListTile(
            title: Text(apod.title),
            subtitle: Text(
              apod.description,
              overflow: TextOverflow.clip,
              maxLines: 2,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<ApodBloc>().add(
                      RemoveFavoriteEvent(apod: apod),
                    );
              },
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DetailApodDialog(apod: apod),
              );
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
      ),
    );
  }
}
