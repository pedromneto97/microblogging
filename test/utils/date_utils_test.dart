import 'package:flutter_test/flutter_test.dart';
import 'package:microblogging/utils/date_utils.dart';

void main() {
  group('Test isToday', () {
    test('Today', () {
      final today = DateTime.now();
      expect(isToday(today), isTrue);
    });

    test('Tomorrow', () {
      final tomorrow = DateTime.now().add(
        const Duration(days: 1),
      );
      expect(isToday(tomorrow), isFalse);
    });

    test('Yesterday', () {
      final yesterday = DateTime.now().subtract(
        const Duration(days: 1),
      );

      expect(isToday(yesterday), isFalse);
    });
  });
}
