

import 'package:flutter_nasa_apod/src/core/erros/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Failure classes', () {
    test('ServerFailure deve ter a mensagem correta e igualdade', () {
      const serverFailure1 = ServerFailure('Server error');
      const serverFailure2 = ServerFailure('Server error');
      const serverFailure3 = ServerFailure('Another error');

      expect(serverFailure1.message, 'Server error');
      
      expect(serverFailure1, equals(serverFailure2));
      expect(serverFailure1, isNot(equals(serverFailure3)));

      expect(serverFailure1.hashCode, equals(serverFailure2.hashCode));
      expect(serverFailure1.hashCode, isNot(equals(serverFailure3.hashCode)));
    });

    test('CacheFailure deve ter a mensagem correta', () {
      const cacheFailure = CacheFailure('Cache error');

      expect(cacheFailure.message, 'Cache error');
    });
  });
}
