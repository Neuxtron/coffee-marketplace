import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:flutter/material.dart';

class KeranjangViewModel extends ChangeNotifier {
  // TODO: remove comment
  // ignore: prefer_final_fields
  List<KeranjangModel> _listKeranjang = [
    KeranjangModel(
      id: "1",
      produk: dummyProduk,
    ),
    KeranjangModel(
      id: "2",
      produk: dummyProduk,
    ),
    KeranjangModel(
      id: "3",
      produk: dummyProduk,
    ),
    KeranjangModel(
      id: "4",
      produk: dummyProduk,
    ),
  ];

  List<KeranjangModel> get listKeranjang => _listKeranjang;

  void setAmount(String id, int amount) {
    final index = _listKeranjang.indexWhere((keranjang) {
      return keranjang.id == id;
    });

    // TODO: amount from api response
    _listKeranjang[index].amount = amount;
    notifyListeners();
  }
}
