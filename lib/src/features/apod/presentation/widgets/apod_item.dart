import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nasa_apod/src/core/utils/date_formatter.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/entities/apod.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/bloc/apod/apod_bloc.dart';

import 'apod_media.dart';

class ApodItem extends StatelessWidget {
  final Apod apod;

  const ApodItem({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    apod.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    apod.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: apod.isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    if (apod.isFavorite) {
                      context
                          .read<ApodBloc>()
                          .add(RemoveFavoriteEvent(apod: apod));
                    } else {
                      context
                          .read<ApodBloc>()
                          .add(SaveFavoriteEvent(apod: apod));
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              DateFormatter.formatToDisplayDate(apod.date),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            ApodMedia(apod: apod),
            const SizedBox(height: 16),
            Text(
              apod.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
