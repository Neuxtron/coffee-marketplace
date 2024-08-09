import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/views/_penjual/widgets/variasi_item_view.dart';
import 'package:flutter/material.dart';
import 'package:coffee_marketplace/models/variasi_model.dart';

class VariasiSection extends StatefulWidget {
  final Function(int index, VariasiModel variasi) onChanged;
  final List<VariasiModel> listVariasi;
  final Function() addVariasi;
  final Function()? removeVariasi;

  const VariasiSection({
    super.key,
    required this.onChanged,
    required this.addVariasi,
    required this.removeVariasi,
    required this.listVariasi,
  });

  @override
  State<VariasiSection> createState() => _VariasiSectionState();
}

class _VariasiSectionState extends State<VariasiSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Variasi:",
          style: TextStyle(fontSize: 12),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.listVariasi.length,
          itemBuilder: (context, index) {
            final variasi = widget.listVariasi[index];

            return VariasiItemView(
              onChanged: widget.onChanged,
              index: index,
              variasi: variasi,
            );
          },
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.removeVariasi != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: widget.removeVariasi,
                      icon: Icon(
                        Icons.remove,
                        color: Colors.red.shade400,
                      ),
                    ),
                  )
                : const SizedBox(),
            IconButton(
              onPressed: widget.addVariasi,
              style: const ButtonStyle(
                side: WidgetStatePropertyAll(
                  BorderSide(color: AppConstants.primary, width: 2),
                ),
              ),
              icon: const Icon(
                Icons.add,
                color: AppConstants.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
