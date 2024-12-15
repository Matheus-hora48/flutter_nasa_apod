import 'package:flutter/material.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/entities/apod.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/widgets/apod_media.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/widgets/video_player_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:mockito/annotations.dart';

@GenerateMocks([VideoPlayerWidget])
void main() {
  group('ApodMedia Widget', () {
    final tDate = DateTime(2022, 1, 1);
    testWidgets('renderiza uma imagem quando mediaType é image',
        (WidgetTester tester) async {
      var apod = Apod(
        title: 'Example Image',
        date: tDate,
        description: 'An example description.',
        mediaType: 'image',
        url: 'https://example.com/image.jpg',
        isFavorite: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApodMedia(apod: apod),
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets(
        'renderiza uma mensagem de fallback quando mediaType é desconhecido',
        (WidgetTester tester) async {
      var apod = Apod(
        title: 'Unknown Media',
        date: tDate,
        description: 'An example description.',
        mediaType: 'unknown',
        url: 'https://example.com/unknown',
        isFavorite: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApodMedia(apod: apod),
          ),
        ),
      );

      expect(find.text('Mídia não disponível'), findsOneWidget);
    });

    testWidgets('renderiza CircularProgressIndicator ao carregar uma imagem',
        (WidgetTester tester) async {
      var apod = Apod(
        title: 'Loading Image',
        date: tDate,
        description: 'An example description.',
        mediaType: 'image',
        url: 'https://example.com/image.jpg',
        isFavorite: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApodMedia(apod: apod),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renderiza um ícone de erro quando o carregamento da imagem falha',
        (WidgetTester tester) async {
      var apod = Apod(
        title: 'Error Image',
        date: tDate,
        description: 'An example description.',
        mediaType: 'image',
        url: 'https://example.com/invalid.jpg',
        isFavorite: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ApodMedia(apod: apod),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.error), findsOneWidget);
    });
  });
}
