import 'package:flutter_nasa_apod/src/core/utils/date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DateFormatter', () {
    test('formatToDisplayDate deve retornar o formato de data correto', () {
      final DateTime date = DateTime(2024, 12, 13);

      final String result = DateFormatter.formatToDisplayDate(date);

      expect(result, '13/12/2024');
    });

    test(
        'formatToDisplayDateTime deve retornar o formato correto de data e hora',
        () {
      final DateTime dateTime = DateTime(2024, 12, 13, 14, 30);

      final String result = DateFormatter.formatToDisplayDateTime(dateTime);

      expect(result, '13/12/2024 14:30');
    });

    test('formatToDisplayDate deve manipular dias e meses de um único dígito', () {
      final DateTime date = DateTime(2024, 5, 9);

      final String result = DateFormatter.formatToDisplayDate(date);

      expect(result, '09/05/2024');
    });

    test(
        'formatToDisplayDateTime deve manipular dia, mês e hora de um único dígito',
        () {
      final DateTime dateTime = DateTime(2024, 5, 9, 1, 5);

      final String result = DateFormatter.formatToDisplayDateTime(dateTime);

      expect(result, '09/05/2024 01:05');
    });
  });
}
