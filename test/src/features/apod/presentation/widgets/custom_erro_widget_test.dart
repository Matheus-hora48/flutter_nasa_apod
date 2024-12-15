import 'package:flutter/material.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/widgets/custom_erro_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomErroWidget', () {
    testWidgets('Exibe a mensagem de erro corretamente', (WidgetTester tester) async {
      const testMessage = 'Ocorreu um erro ao carregar os dados';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomErroWidget(message: testMessage),
          ),
        ),
      );

      expect(find.text(testMessage), findsOneWidget);

      final centerWidget = find.byType(Center);
      expect(centerWidget, findsOneWidget);

      final paddingWidget = find.byType(Padding);
      expect(paddingWidget, findsOneWidget);

      final padding = tester.widget<Padding>(paddingWidget);
      expect(padding.padding, const EdgeInsets.all(16));
    });
  });
}
