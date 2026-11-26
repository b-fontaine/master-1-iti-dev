// Tests unitaires de la règle estReussite, dont un test paramétré par une liste de cas.
import 'package:flutter_test/flutter_test.dart';
import 'package:projet_fil_rouge/features/jets/domain/regles/est_reussite.dart';

void main() {
  test('un total égal au degré de difficulté est une réussite', () {
    expect(estReussite(10, 10), isTrue);
  });

  group('estReussite, cas par cas', () {
    const cas = [
      (total: 1, dd: 10, attendu: false),
      (total: 9, dd: 10, attendu: false),
      (total: 10, dd: 10, attendu: true),
      (total: 11, dd: 10, attendu: true),
      (total: 20, dd: 20, attendu: true),
      (total: 19, dd: 20, attendu: false),
    ];

    for (final c in cas) {
      test('total ${c.total} contre DD ${c.dd} donne ${c.attendu}', () {
        expect(estReussite(c.total, c.dd), c.attendu);
      });
    }
  });
}
