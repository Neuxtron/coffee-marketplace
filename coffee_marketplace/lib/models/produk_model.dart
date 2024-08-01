import 'package:coffee_marketplace/models/penjual_model.dart';
import 'package:coffee_marketplace/models/variasi_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';

class ProdukModel {
  final String id;
  final String nama;
  final String deskripsi;
  final int harga;
  final String idKategori;
  final int beratProduk;
  final String merk;
  final List<String> gambar;
  final List<VariasiModel> variasi;
  final PenjualModel penjual;

  ProdukModel({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.idKategori,
    required this.beratProduk,
    required this.merk,
    required this.gambar,
    required this.variasi,
    required this.penjual,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    final gambar = (json["gambar"] as List).map((item) {
      final fileName = item["fileName"];
      return "${AppConstants.baseUrl}/images/$fileName";
    }).toList();

    final variasi = json["variasi"] as List;

    return ProdukModel(
      id: json["id"],
      nama: json["nama"],
      deskripsi: json["deskripsi"],
      harga: json["harga"],
      idKategori: json["idKategori"],
      beratProduk: json["beratProduk"],
      merk: json["merk"],
      gambar: gambar,
      variasi: variasi.map((e) => VariasiModel.fromJson(e)).toList(),
      penjual: PenjualModel.fromJson(json["penjual"]),
    );
  }

  // TODO: thumbnail
  String get thumbnail {
    return gambar[0];
  }
}

final dummyProduk = ProdukModel(
  id: "sajfamnflkasm",
  nama: "Kopi Luwak Gayo",
  deskripsi:
      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Labore autem magnam libero quos aspernatur dolores neque? Perferendis cumque porro labore, temporibus soluta quo voluptatum natus iure ullam doloribus voluptatem eum aspernatur cum, eveniet blanditiis suscipit! Velit culpa fugiat illum minima blanditiis sapiente incidunt officia eveniet aspernatur, necessitatibus voluptatum animi totam, facilis voluptatem nostrum vitae nulla hic natus! Debitis temporibus odio, doloribus incidunt molestias impedit.",
  harga: 110999,
  idKategori: "1",
  beratProduk: 200,
  merk: "PRESO",
  gambar: ["${AppConstants.baseUrl}/images/contoh.jpg"],
  variasi: [
    VariasiModel(id: "1", nama: "Biji Kopi", stok: 999),
    VariasiModel(id: "2", nama: "Bubuk Halus", stok: 999),
    VariasiModel(id: "3", nama: "Bubuk Sedang", stok: 999),
    VariasiModel(id: "4", nama: "Bubuk Kasar", stok: 999),
  ],
  penjual: PenjualModel(
    id: "1",
    namaToko: "Toko dabes banget",
    idKecamatanToko: "235",
  ),
);
// final List<ProdukModel> dummyListProduk = [
//   dummyProduk,
//   dummyProduk,
//   dummyProduk,
//   dummyProduk,
//   dummyProduk,
//   dummyProduk,
// ];
final List<ProdukModel> dummyBestSellerProduk = [
  dummyProduk,
  dummyProduk,
  dummyProduk,
  dummyProduk,
];
