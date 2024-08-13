import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:flutter/material.dart';

class InputItem extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? prefix;
  final String? suffix;
  final TextInputType keyboardType;
  final bool multiline;
  final bool isShort;
  final bool optional;
  final bool obscureText;
  final String? Function(String? value)? validator;

  const InputItem({
    super.key,
    required this.controller,
    required this.label,
    required this.keyboardType,
    this.prefix,
    this.suffix,
    this.multiline = false,
    this.isShort = false,
    this.optional = false,
    this.obscureText = false,
    this.validator,
  });

  String? Function(String? value)? get _finalValidator {
    if (validator != null) return validator;
    if (!optional) return defaultValidator;
    return null;
  }

  String? defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '$label tidak boleh kosong';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        SizedBox(
          width: isShort ? 200 : null,
          child: TextFormField(
            controller: controller,
            validator: _finalValidator,
            keyboardType: multiline ? TextInputType.multiline : keyboardType,
            minLines: multiline ? 3 : 1,
            maxLines: multiline ? null : 1,
            obscureText: obscureText,
            style: const TextStyle(fontSize: 14),
            decoration: buildDecoration(),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  InputDecoration buildDecoration() {
    return InputDecoration(
      filled: true,
      isDense: true,
      prefixText: prefix,
      suffixText: suffix,
      fillColor: AppConstants.secondary.withOpacity(.5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      enabledBorder: buildBorder(),
      focusedBorder: buildBorder(),
      errorBorder: buildBorder(),
      focusedErrorBorder: buildBorder(),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppConstants.secondaryAlt),
    );
  }
}
