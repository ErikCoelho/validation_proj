import 'package:flutter/services.dart';

class MaskInput extends TextInputFormatter {
  final String mask;

  MaskInput({required this.mask});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = newValue.text.replaceAll(r'\D', '');
    var formatted = mask;
    for (var i = 0; i < value.length; i++) {
      formatted = formatted.replaceFirst('#', value[i]);
    }

    final lastHash = formatted.indexOf('#');

    if (lastHash != -1) {
      formatted = formatted.substring(0, lastHash);
      if (RegExp(r'\D$').hasMatch(formatted)) {
        formatted =
            formatted.split('').getRange(0, formatted.length - 1).join();
      }
    }

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.fromPosition(
        TextPosition(offset: formatted.length),
      ),
    );
  }
}
