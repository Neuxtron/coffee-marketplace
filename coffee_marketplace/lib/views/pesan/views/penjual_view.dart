import 'package:flutter/material.dart';

class PenjualView extends StatelessWidget {
  final bool isPenjual;
  final Function() updateState;

  const PenjualView({
    super.key,
    required this.isPenjual,
    required this.updateState,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Penjual view"));
  }
}
