import 'package:om_pay_console/utils/validators.dart';
import 'package:test/test.dart';

void main() {
  group('Validator', () {
    test('isValidPhoneNumber', () {
      expect(Validator.isValidPhoneNumber('221771234567'), true);
      expect(Validator.isValidPhoneNumber('123'), false);
      expect(Validator.isValidPhoneNumber('abc'), false);
    });

    test('isValidAmount', () {
      expect(Validator.isValidAmount('100.50'), true);
      expect(Validator.isValidAmount('100'), true);
      expect(Validator.isValidAmount('-10'), false);
      expect(Validator.isValidAmount('abc'), false);
    });

    test('isValidTransactionType', () {
      expect(Validator.isValidTransactionType('transfert'), true);
      expect(Validator.isValidTransactionType('dépôt'), true);
      expect(Validator.isValidTransactionType('invalid'), false);
    });

    test('isValidId', () {
      expect(Validator.isValidId('123'), true);
      expect(Validator.isValidId(''), false);
    });

    test('isValidOtp', () {
      expect(Validator.isValidOtp('123456'), true);
      expect(Validator.isValidOtp('123'), false);
      expect(Validator.isValidOtp('abcdef'), false);
    });
  });
}
