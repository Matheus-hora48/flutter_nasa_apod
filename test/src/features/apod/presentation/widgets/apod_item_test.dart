import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/widgets/apod_media.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/bloc/apod/apod_bloc.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/entities/apod.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/widgets/apod_item.dart';
import 'package:mockito/annotations.dart';

import 'apod_item_test.mocks.dart';

@GenerateMocks([ApodBloc])
void main() {
  group('ApodItem Widget', () {
    late Apod apod;
    late MockApodBloc mockApodBloc;

    final tDate = DateTime(2022, 1, 1);

    setUp(() {
      apod = Apod(
        title: 'Test Title',
        date: tDate,
        description: 'Test Description',
        mediaType: 'image',
        url: 'https://testurl.com',
        isFavorite: false,
      );
      mockApodBloc = MockApodBloc();
    });

    testWidgets('exibe título, descrição e ícone favorito', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ApodBloc>.value(
            value: mockApodBloc,
            child: ApodItem(apod: apod),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('exibe a data formatada corretamente', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ApodBloc>.value(
            value: mockApodBloc,
            child: ApodItem(apod: apod),
          ),
        ),
      );

      expect(find.text('01/01/2022'), findsOneWidget);
    });

    testWidgets('renderiza o widget ApodMedia', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ApodBloc>.value(
            value: mockApodBloc,
            child: ApodItem(apod: apod),
          ),
        ),
      );

      expect(find.byType(ApodMedia), findsOneWidget);
    });

    testWidgets('trunca o título se for muito longo', (tester) async {
      final longTitleApod = Apod(
        title: 'Título muito longo que ultrapassa o limite da tela',
        date: tDate,
        description: 'Test Description',
        mediaType: 'image',
        url: 'https://testurl.com',
        isFavorite: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ApodBloc>.value(
            value: mockApodBloc,
            child: ApodItem(apod: longTitleApod),
          ),
        ),
      );

      expect(find.textContaining('Título muito longo'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('o ícone de favorito inicial é desmarcado', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ApodBloc>.value(
            value: mockApodBloc,
            child: ApodItem(apod: apod),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
}
