import 'package:coffee_marketplace/models/ongkir_model.dart';
import 'package:coffee_marketplace/viewmodels/daerah_view_model.dart';
import 'package:coffee_marketplace/views/checkout/checkout_section_item.dart';
import 'package:coffee_marketplace/views/pengiriman/kurir_item.dart';
import 'package:coffee_marketplace/views/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:coffee_marketplace/models/kurir_model.dart';
import 'package:provider/provider.dart';

class PengirimanSection extends StatefulWidget {
  final Function(OngkirModel ongkir) onChange;

  const PengirimanSection({super.key, required this.onChange});

  @override
  State<PengirimanSection> createState() => _PengirimanSectionState();
}

class _PengirimanSectionState extends State<PengirimanSection> {
  late KurirModel _selectedKurir;
  late OngkirModel _selectedOngkir;

  List<KurirModel> get _listKurir => context.read<DaerahViewModel>().listKurir;

  void selectKurir(Object? value) {
    if (value == null) return;
    final response = value as KurirValue;
    setState(() {
      _selectedKurir = response.kurir;
      _selectedOngkir = response.ongkir;
    });
    widget.onChange(_selectedOngkir);
  }

  void getData() {
    _selectedKurir = _listKurir[0];
    _selectedOngkir = _listKurir[0].listOngkir![0];
  }

  @override
  void initState() {
    super.initState();
    getData();
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedKurir.nama,
                    style: const TextStyle(
                      fontFamily: "Abhaya Libre",
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "${_selectedOngkir.deskripsi} (${_selectedOngkir.nama})",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
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
