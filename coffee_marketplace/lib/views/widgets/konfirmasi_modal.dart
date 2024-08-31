import 'package:flutter/material.dart';

class KonfirmasiModal extends StatelessWidget {
  final String text;
  final String buttonText;

  const KonfirmasiModal({
    super.key,
    required this.text,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.all(20),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.grey.shade200),
            foregroundColor: const WidgetStatePropertyAll(Colors.grey),
          ),
          child: const Text("Batal"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.green.shade100),
            foregroundColor: const WidgetStatePropertyAll(Colors.red),
          ),
          child: Text(buttonText),
        ),
      ],
    );
  }
}
