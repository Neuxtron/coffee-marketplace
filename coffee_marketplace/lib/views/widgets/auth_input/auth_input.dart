import 'package:coffee_marketplace/views/widgets/auth_input/visibility_button.dart';
import 'package:flutter/material.dart';

class AuthInput extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String? value) validator;
  final String hintText;
  final bool isPassword;
  final Widget? icon;
  final TextInputType keyboardType;
  final EdgeInsets margin;
  final bool multiline;

  const AuthInput({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    this.isPassword = false,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.margin = const EdgeInsets.only(bottom: 5),
    this.multiline = false,
  });

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: Stack(
        children: [
          TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword && !_isVisible,
            keyboardType: widget.multiline
                ? TextInputType.multiline
                : widget.keyboardType,
            decoration: buildDecoration(),
            validator: widget.validator,
            minLines: widget.multiline ? 3 : 1,
            maxLines: widget.multiline ? null : 1,
          ),
          VisibilityButton(
            isPassword: widget.isPassword,
            onPressed: () => setState(() => _isVisible = !_isVisible),
            isVisible: _isVisible,
          ),
        ],
      ),
    );
  }

  InputDecoration buildDecoration() {
    return InputDecoration(
      hintText: widget.hintText,
      hintStyle: const TextStyle(
        fontFamily: "Abhaya Libre",
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: Colors.white,
      prefixIconConstraints: const BoxConstraints(minWidth: 30),
      prefixIcon: widget.icon != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: widget.icon,
            )
          : null,
      enabledBorder: buildBorder(),
      focusedBorder: buildBorder(),
      errorBorder: buildBorder(isError: true),
      focusedErrorBorder: buildBorder(isError: true),
    );
  }

  OutlineInputBorder buildBorder({bool isError = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: isError ? Colors.red : Colors.grey.shade400,
      ),
    );
  }
}
