import 'package:flutter_nasa_apod/src/core/utils/youtube_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('extractVideoId', () {
    test('Extrai o videoId de uma URL completa com parâmetro v', () {
      const url = 'https://www.youtube.com/watch?v=abcd1234';
      final result = extractVideoId(url);
      expect(result, 'abcd1234');
    });

    test('Extrai o videoId de uma URL encurtada', () {
      const url = 'https://youtu.be/abcd1234';
      final result = extractVideoId(url);
      expect(result, 'abcd1234');
    });

    test('Extrai o videoId de uma URL embed', () {
      const url = 'https://www.youtube.com/embed/7QB_MOemCqs?rel=0';
      final result = extractVideoId(url);
      expect(result, '7QB_MOemCqs');
    });

    test('Extrai o videoId de uma URL com múltiplos parâmetros', () {
      const url = 'https://www.youtube.com/watch?v=abcd1234&list=xyz&index=2';
      final result = extractVideoId(url);
      expect(result, 'abcd1234');
    });

    test('Retorna erro para URL sem parâmetro v ou host youtu.be', () {
      const url = 'https://www.youtube.com/';
      expect(() => extractVideoId(url), throwsFormatException);
    });

    test('Retorna erro para URL inválida', () {
      const url = 'not_a_valid_url';
      expect(() => extractVideoId(url), throwsFormatException);
    });
  });
}
