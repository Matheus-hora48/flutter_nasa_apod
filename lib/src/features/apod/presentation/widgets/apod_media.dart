import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/apod.dart';
import 'video_player_widget.dart';

class ApodMedia extends StatelessWidget {
  final Apod apod;

  const ApodMedia({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    if (apod.mediaType == 'image') {
      return SizedBox(
        width: double.infinity,
        height: 400,
        child: CachedNetworkImage(
          imageUrl: apod.url,
          fit: BoxFit.contain,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.error),
          ),
        ),
      );
    } else if (apod.mediaType == 'video') {
      return VideoPlayerWidget(
        videoId: apod.url,
      );
    } else {
      return const Center(
        child: Text("Mídia não disponível"),
      );
    }
  }
}
