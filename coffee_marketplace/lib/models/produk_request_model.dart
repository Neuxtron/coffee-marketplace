import 'dart:io';

class ProdukRequestModel {
  final String? id;
  final String nama;
  final String deskripsi;
  final int harga;
  final int beratProduk;
  final String? merk;
  final String idKategori;
  final File? gambar;
  final List<Map<String, dynamic>> variasi;

  ProdukRequestModel({
    this.id,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.beratProduk,
    required this.merk,
    required this.idKategori,
    required this.gambar,
    required this.variasi,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nama": nama,
      "deskripsi": deskripsi,
      "harga": harga,
      "beratProduk": beratProduk,
      "merk": merk,
      "idKategori": idKategori,
      "variasi": variasi,
    };
  }
}
