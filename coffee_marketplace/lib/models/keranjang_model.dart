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

  factory KeranjangModel.fromJson(Map<String, dynamic> json) {
    return KeranjangModel(
      id: json["id"],
      produk: ProdukModel.fromJson(json["produk"]),
      variasi: VariasiModel.fromJson(json["variasi"]),
      amount: json["amount"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idProduk": produk,
      "idVariasi": variasi,
      "amount": amount,
    };
  }
}
