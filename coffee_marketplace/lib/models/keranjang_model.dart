import 'package:coffee_marketplace/models/produk_model.dart';

class KeranjangModel {
  final String? id;
  final ProdukModel produk;
  int amount;
  bool isChecked = false;

  KeranjangModel({
    required this.produk,
    this.id,
    this.amount = 1,
  });
}
