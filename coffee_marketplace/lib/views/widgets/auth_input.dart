import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthInput extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String? value) validator;
  final String hintText;
  final bool isPassword;
  final String iconPath;

  const AuthInput({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    this.isPassword = false,
    required this.iconPath,
  });

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        children: [
          TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword && !_isVisible,
            decoration: InputDecoration(
              hintText: widget.hintText,
              filled: true,
              fillColor: Colors.white,
              prefixIconConstraints: const BoxConstraints(maxHeight: 30),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SvgPicture.asset(widget.iconPath),
              ),
              enabledBorder: buildBorder(),
              focusedBorder: buildBorder(),
              errorBorder: buildBorder(isError: true),
              focusedErrorBorder: buildBorder(isError: true),
            ),
            validator: widget.validator,
          ),
          widget.isPassword
              ? Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => setState(() => _isVisible = !_isVisible),
                    color: Colors.grey,
                    icon: Icon(
                      _isVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
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
