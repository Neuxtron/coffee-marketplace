import 'package:coffee_marketplace/models/variasi_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';

class ProdukModel {
  final String id;
  final String nama;
  final String deskripsi;
  final int harga;
  final String idKatgegori;
  final int beratProduk;
  final String merk;
  final List<String> gambar;
  final List<VariasiModel> variasi;
  // TODO: id penjual

  ProdukModel({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.idKatgegori,
    required this.beratProduk,
    required this.merk,
    required this.gambar,
    required this.variasi,
  });

  // TODO: get thumbnail
}

final dummyProduk = ProdukModel(
  id: "sajfamnflkasm",
  nama: "Kopi Luwak Gayo",
  deskripsi:
      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Labore autem magnam libero quos aspernatur dolores neque? Perferendis cumque porro labore, temporibus soluta quo voluptatum natus iure ullam doloribus voluptatem eum aspernatur cum, eveniet blanditiis suscipit! Velit culpa fugiat illum minima blanditiis sapiente incidunt officia eveniet aspernatur, necessitatibus voluptatum animi totam, facilis voluptatem nostrum vitae nulla hic natus! Debitis temporibus odio, doloribus incidunt molestias impedit.",
  harga: 110999,
  idKatgegori: "1",
  beratProduk: 200,
  merk: "PRESO",
  gambar: ["${AppConstants.baseUrl}/images/contoh.jpg"],
  variasi: [
    VariasiModel(id: "1", nama: "Biji Kopi", stok: 999),
    VariasiModel(id: "2", nama: "Bubuk Halus", stok: 999),
    VariasiModel(id: "3", nama: "Bubuk Sedang", stok: 999),
    VariasiModel(id: "4", nama: "Bubuk Kasar", stok: 999),
  ],
);
final List<ProdukModel> dummyListProduk = [
  dummyProduk,
  dummyProduk,
  dummyProduk,
  dummyProduk,
  dummyProduk,
  dummyProduk,
];
final List<ProdukModel> dummyBestSellerProduk = [
  dummyProduk,
  dummyProduk,
  dummyProduk,
  dummyProduk,
];
