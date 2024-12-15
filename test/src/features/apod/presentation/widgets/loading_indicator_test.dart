import 'package:flutter/material.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/widgets/loading_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoadingIndicator displays CircularProgressIndicator', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LoadingIndicator(),
      ),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
    expect(find.byType(Center), findsOneWidget);
  });
}
