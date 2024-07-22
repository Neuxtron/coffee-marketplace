import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/models/variasi_model.dart';

class KeranjangModel {
  final String? id;
  final ProdukModel produk;
  final VariasiModel variasi;
  int amount;
  bool isChecked = false;

  KeranjangModel({
    required this.produk,
    required this.variasi,
    this.id,
    this.amount = 1,
  });
}
