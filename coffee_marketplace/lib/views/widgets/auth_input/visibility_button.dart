import 'package:flutter/material.dart';

class VisibilityButton extends StatelessWidget {
  final bool isPassword;
  final Function() onPressed;
  final bool isVisible;

  const VisibilityButton({
    super.key,
    required this.isPassword,
    required this.onPressed,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    if (!isPassword) return const SizedBox();

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: IconButton(
          onPressed: onPressed,
          color: Colors.grey,
          icon: Icon(
            isVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
    );
  }
}
