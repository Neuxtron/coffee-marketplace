import 'package:coffee_marketplace/models/kurir_model.dart';
import 'package:coffee_marketplace/models/ongkir_model.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/views/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class KurirItem extends StatefulWidget {
  final KurirModel kurir;
  const KurirItem({super.key, required this.kurir});

  @override
  State<KurirItem> createState() => _KurirItemState();
}

class _KurirItemState extends State<KurirItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
          leading: RoundedImage(
            imageUrl: widget.kurir.imgUrl,
            height: 40,
            width: 40,
            radius: 10,
          ),
          trailing: Icon(
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.grey,
          ),
          title: Text(
            widget.kurir.nama,
            style: const TextStyle(
              fontFamily: "Abhaya Libre",
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
        _isExpanded
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.kurir.listOngkir!.length,
                itemBuilder: (context, index) {
                  final ongkir = widget.kurir.listOngkir![index];
                  final ongkirString = AppHelpers.formatHarga(ongkir.ongkir);

                  return ListTile(
                    onTap: () {
                      final value = KurirValue(
                        kurir: widget.kurir,
                        ongkir: ongkir,
                      );
                      Navigator.pop(context, value);
                    },
                    titleTextStyle: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    contentPadding: const EdgeInsets.only(
                      left: 50,
                      bottom: 5,
                      top: 5,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${ongkir.deskripsi} (${ongkir.nama})",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text("Estimasi pengiriman: ${ongkir.estimasi}"),
                        Text(ongkirString),
                      ],
                    ),
                  );
                },
              )
            : const SizedBox(),
      ],
    );
  }
}

class KurirValue {
  final KurirModel kurir;
  final OngkirModel ongkir;

  KurirValue({
    required this.kurir,
    required this.ongkir,
  });
}
