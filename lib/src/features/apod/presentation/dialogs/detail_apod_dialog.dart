import 'package:flutter/material.dart';
import 'package:flutter_nasa_apod/src/core/utils/date_formatter.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/entities/apod.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/widgets/apod_media.dart';

class DetailApodDialog extends StatelessWidget {
  final Apod apod;

  const DetailApodDialog({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(apod.title),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ApodMedia(apod: apod),
            const SizedBox(height: 8),
            Text(
              DateFormatter.formatToDisplayDate(apod.date),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              apod.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}
