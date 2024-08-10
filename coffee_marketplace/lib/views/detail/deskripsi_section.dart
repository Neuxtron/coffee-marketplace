import 'package:flutter/material.dart';

class DeskripsiSection extends StatelessWidget {
  final String deskripsi;
  const DeskripsiSection({super.key, required this.deskripsi});

  @override
  Widget build(BuildContext context) {
    return Text(
      deskripsi,
      textAlign: TextAlign.justify,
    );
  }
}
