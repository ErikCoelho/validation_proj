import 'package:flutter/services.dart';
import 'package:validator/core/utils/currency_mask.dart';
import 'package:validator/core/utils/mask_input.dart';

class Validators {
  TextInputType getKeyboardType(String? inputType) {
    switch (inputType) {
      case 'email':
        return TextInputType.emailAddress;
      case 'cep':
      case 'cpf':
      case 'money':
      case 'int':
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
          LengthLimitingTextInputFormatter(8),
          MaskInput(mask: '#####-###')
        ];
      case 'cpf':
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
          MaskInput(mask: '###.###.###-##'),
        ];
      case 'money':
        return [
          FilteringTextInputFormatter.digitsOnly,
          CurrencyMask(symbol: 'R\$ ', decimal: '.', cents: ',')
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
