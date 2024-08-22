import 'package:flutter/material.dart';
import 'package:coffee_marketplace/models/daerah_model.dart';

class DaerahDropdown extends StatelessWidget {
  final Function(String? value) onChange;
  final String? value;
  final List<DaerahModel> listDaerah;
  final String title;
  final bool show;
  final bool isLoading;

  const DaerahDropdown({
    super.key,
    required this.onChange,
    required this.value,
    required this.listDaerah,
    required this.title,
    this.show = true,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox();
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            title,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: value,
              isExpanded: true,
              borderRadius: BorderRadius.circular(8),
              onChanged: onChange,
              items: listDaerah.map((kecamatan) {
                return DropdownMenuItem(
                  value: kecamatan.id,
                  child: Text(kecamatan.nama),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
