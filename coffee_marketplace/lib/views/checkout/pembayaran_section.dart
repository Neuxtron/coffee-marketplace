import 'package:coffee_marketplace/views/checkout/checkout_section_item.dart';
import 'package:coffee_marketplace/views/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:coffee_marketplace/models/metode_bayar_model.dart';

class PembayaranSection extends StatefulWidget {
  final Function(String idMetode) onChange;
  const PembayaranSection({super.key, required this.onChange});

  @override
  State<PembayaranSection> createState() => _PembayaranSectionState();
}

class _PembayaranSectionState extends State<PembayaranSection> {
  late MetodeBayarModel _selectedMetode;

  final _listMetode = dummyMetodeBayar;

  // OPTIMIZE: better loading detection
  bool get _loading => _listMetode.isEmpty;

  void selectMetode(Object? value) {
    if (value == null) return;
    final metodeBayar = value as MetodeBayarModel;
    setState(() => _selectedMetode = metodeBayar);
    widget.onChange(metodeBayar.id);
  }

  void getData() {
    if (!_loading) {
      _selectedMetode = _listMetode[0];
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      // TODO: loading builder
    }

    return CheckoutSectionItem(
      icon: SvgPicture.asset("assets/icons/ic_pembayaran.svg"),
      title: "Metode Pembayaran",
      minHeight: 0,
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            "/pembayaran",
            arguments: _listMetode,
          ).then(selectMetode);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              RoundedImage(
                imageUrl: _selectedMetode.imgUrl,
                height: 60,
                width: 60,
                radius: 10,
              ),
              const SizedBox(width: 20),
              Text(
                _selectedMetode.nama,
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
