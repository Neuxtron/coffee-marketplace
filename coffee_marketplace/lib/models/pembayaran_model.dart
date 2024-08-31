import 'package:coffee_marketplace/models/keranjang_model.dart';

class PembayaranModel {
  final int subtotal;
  final int ongkir;
  final String metodeBayar;
  final List<KeranjangModel> listKeranjang;
  final String kurir;

  PembayaranModel({
    required this.subtotal,
    required this.ongkir,
    required this.metodeBayar,
    required this.listKeranjang,
    required this.kurir,
  });

  Map<String, dynamic> get order {
    return {
      "subtotal": subtotal,
      "ongkir": ongkir,
      "metodeBayar": metodeBayar,
      "kurir": kurir,
    };
  }
}
