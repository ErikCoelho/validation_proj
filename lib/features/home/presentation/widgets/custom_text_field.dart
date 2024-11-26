import 'package:flutter/material.dart';
import 'package:validator/core/utils/validators.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? inputType;
  final void Function(String? value)? onSaved;

  const CustomTextField({
    super.key,
    required this.label,
    this.inputType,
    this.hint,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    final validator = Validators();
    return TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onSaved: onSaved,
        keyboardType: validator.getKeyboardType(inputType),
        inputFormatters: validator.getInputFormatters(inputType),
        validator: (value) {
          return validator.validateInput(value, inputType);
        });
  }
}
