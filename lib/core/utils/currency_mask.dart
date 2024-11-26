import 'package:flutter/services.dart';

class CurrencyMask extends TextInputFormatter {
  final String symbol;
  final String decimal;
  final String cents;

  CurrencyMask({
    required this.symbol,
    required this.decimal,
    required this.cents,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = newValue.text.replaceAll(RegExp(r'\D'), '');

    value = (int.tryParse(value) ?? 0).toString();

    if (value.length < 3) {
      value = value.padLeft(3, '0');
    }

    value = value.split('').reversed.join();

    final listCharacters = [];
    var decimalCount = 0;

    for (var i = 0; i < value.length; i++) {
      if (i == 2) {
        listCharacters.insert(0, cents);
      }

      if (i > 2) {
        decimalCount++;
      }

      if (decimalCount == 3) {
        listCharacters.insert(0, decimal);
        decimalCount = 0;
      }

      listCharacters.insert(0, value[i]);
    }

    listCharacters.insert(0, symbol);
    var formatted = listCharacters.join();

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.fromPosition(
        TextPosition(offset: formatted.length),
      ),
    );
  }
}
