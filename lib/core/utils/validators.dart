import 'package:flutter/services.dart';

class Validators {
  TextInputType getKeyboardType(String? inputType) {
    switch (inputType) {
      case 'email':
        return TextInputType.emailAddress;
      case 'cep':
      case 'cpf':
      case 'money':
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter> getInputFormatters(String? inputType) {
    switch (inputType) {
      case 'cep':
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(8)
        ];
      case 'cpf':
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
          CPFMask(),
        ];
      default:
        return [];
    }
  }

  String? validateInput(String? value, String? inputType) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }

    switch (inputType) {
      case 'email':
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(value)) {
          return 'Por favor, insira um e-mail válido';
        }
        break;
      case 'cep':
        if (value.length != 8) {
          return 'CEP deve conter 8 dígitos';
        }
        break;
      case 'cpf':
        if (value.length != 11) {
          return 'CPF deve conter 11 dígitos';
        }
      case 'nome':
        if (value.length < 3) {
          return 'O nome deve ter pelo menos 3 caracteres';
        }
        break;
      default:
        break;
    }
    return null;
  }
}

class CPFMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var cpf = newValue.text;
    if (cpf.length > 14) {
      return oldValue;
    }
    cpf = cpf.replaceAll(r'\D', '');

    var formatted = '';
    for (var i = 0; i < cpf.length; i++) {
      if ([3, 6, 9].contains(i)) {
        formatted += i == 9 ? '-' : '.';
      }
      formatted += cpf[i];
    }

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.fromPosition(
        TextPosition(offset: formatted.length),
      ),
    );
  }
}
