import 'package:flutter/material.dart';

class JudulSection extends StatelessWidget {
  final String nama;
  const JudulSection({super.key, required this.nama});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Pesanan $nama",
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
