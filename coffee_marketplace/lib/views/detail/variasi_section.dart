import 'package:coffee_marketplace/models/variasi_model.dart';
import 'package:coffee_marketplace/views/detail/variasi_item.dart';
import 'package:flutter/material.dart';

class VariasiSection extends StatefulWidget {
  final List<VariasiModel> listVariasi;
  final Function(VariasiModel variasiId) selectVariasi;

  const VariasiSection({
    super.key,
    required this.listVariasi,
    required this.selectVariasi,
  });

  @override
  State<VariasiSection> createState() => _VariasiSectionState();
}

class _VariasiSectionState extends State<VariasiSection> {
  VariasiModel? selectedVariasi;

  void selectVariasi(VariasiModel variasi) {
    if (variasi == selectedVariasi) {
      setState(() => selectedVariasi = null);
      return;
    }
    setState(() => selectedVariasi = variasi);
    widget.selectVariasi(variasi);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 50),
      child: Column(
        children: [
          const Text(
            "Pilih variasi",
            style: TextStyle(
              fontFamily: "Abhaya Libre",
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: widget.listVariasi.length,
              itemBuilder: (context, index) {
                final variasi = widget.listVariasi[index];
                return VariasiItem(
                  variasi: variasi,
                  selected: selectedVariasi == variasi,
                  onPressed: () => selectVariasi(variasi),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
