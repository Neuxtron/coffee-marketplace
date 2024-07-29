import 'package:coffee_marketplace/views/checkout/checkout_section_item.dart';
import 'package:coffee_marketplace/views/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:coffee_marketplace/models/kurir_model.dart';

class PengirimanSection extends StatefulWidget {
  final Function(String idKurir) onChange;
  final List<KurirModel> listKurir;

  const PengirimanSection({
    super.key,
    required this.onChange,
    required this.listKurir,
  });

  @override
  State<PengirimanSection> createState() => _PengirimanSectionState();
}

class _PengirimanSectionState extends State<PengirimanSection> {
  late KurirModel _selectedKurir;

  void selectKurir(Object? value) {
    if (value == null) return;
    final kurir = value as KurirModel;
    setState(() => _selectedKurir = kurir);
    widget.onChange(kurir.id);
  }

  @override
  void initState() {
    super.initState();
    _selectedKurir = widget.listKurir[0];
  }

  @override
  Widget build(BuildContext context) {
    return CheckoutSectionItem(
      icon: SvgPicture.asset("assets/icons/ic_pengiriman.svg"),
      title: "Pengiriman",
      minHeight: 0,
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            "/pengiriman",
            arguments: widget.listKurir,
          ).then(selectKurir);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              RoundedImage(
                imageUrl: _selectedKurir.imgUrl,
                height: 60,
                width: 60,
                radius: 10,
              ),
              const SizedBox(width: 20),
              Text(
                _selectedKurir.nama,
                style: const TextStyle(
                  fontFamily: "Abhaya Libre",
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const Expanded(child: SizedBox()),
              const Icon(Icons.keyboard_arrow_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
