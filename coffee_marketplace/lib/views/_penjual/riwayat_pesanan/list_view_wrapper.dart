import 'package:flutter/material.dart';

class ListViewWrapper extends StatelessWidget {
  final int length;
  final Widget? Function(BuildContext context, int index) itemBuilder;

  const ListViewWrapper({
    super.key,
    required this.length,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: length,
      itemBuilder: itemBuilder,
    );
  }
}
