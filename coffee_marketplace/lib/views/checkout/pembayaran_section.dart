import 'package:coffee_marketplace/viewmodels/metode_bayar_view_model.dart';
import 'package:coffee_marketplace/views/checkout/checkout_section_item.dart';
import 'package:coffee_marketplace/views/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:coffee_marketplace/models/metode_bayar_model.dart';
import 'package:provider/provider.dart';

class PembayaranSection extends StatefulWidget {
  final Function(String idMetode) onChange;
  const PembayaranSection({super.key, required this.onChange});

  @override
  State<PembayaranSection> createState() => _PembayaranSectionState();
}

class _PembayaranSectionState extends State<PembayaranSection> {
  late MetodeBayarModel _selectedMetode;

  List<MetodeBayarModel> get _listMetode =>
      context.read<MetodeBayarViewModel>().listMetode;

  void selectMetode(Object? value) {
    if (value == null) return;
    final metodeBayar = value as MetodeBayarModel;
    setState(() => _selectedMetode = metodeBayar);
    widget.onChange(metodeBayar.id);
  }

  void getData() {
    if (_listMetode.isNotEmpty) {
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
    if (_listMetode.isEmpty) return const SizedBox();

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
