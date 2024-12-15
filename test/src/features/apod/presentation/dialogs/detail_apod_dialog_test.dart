import 'package:flutter/material.dart';
import 'package:flutter_nasa_apod/src/core/utils/date_formatter.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/dialogs/detail_apod_dialog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_nasa_apod/src/features/apod/domain/entities/apod.dart';

void main() {
  testWidgets('DetailApodDialog exibe os detalhes do apod corretamente', (
    WidgetTester tester,
  ) async {
    final tDate = DateTime(2022, 1, 1);
    final apod = Apod(
      title: 'Test Title',
      date: tDate,
      description: 'This is a test description of the APOD.',
      mediaType: 'image',
      url: 'https://example.com',
      isFavorite: false,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DetailApodDialog(apod: apod),
        ),
      ),
    );

    expect(find.text('Test Title'), findsOneWidget);

    expect(
      find.text(DateFormatter.formatToDisplayDate(tDate)),
      findsOneWidget,
    );

    expect(
      find.text('This is a test description of the APOD.'),
      findsOneWidget,
    );

    expect(find.text('Fechar'), findsOneWidget);

    await tester.tap(find.text('Fechar'));
    await tester.pumpAndSettle();

    expect(find.text('Test Title'), findsNothing);
  });
}
