import 'package:coffee_marketplace/views/home/pesan_button.dart';
import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  final TextEditingController controller;
  final Function() onSearch;

  const SearchSection({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 14),
              decoration: buildDecoration(),
            ),
          ),
        ),
        const PesanButton(),
      ],
    );
  }

  InputDecoration buildDecoration() {
    return InputDecoration(
      hintText: "Cari produk...",
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
      enabledBorder: buildBorder(),
      focusedBorder: buildBorder(),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );
  }
}
