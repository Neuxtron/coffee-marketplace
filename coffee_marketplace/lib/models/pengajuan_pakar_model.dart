import 'package:coffee_marketplace/models/pakar_model.dart';

class PengajuanPakarModel {
  final String id;
  final PakarModel pakar;
  final String pesan;

  PengajuanPakarModel({
    required this.id,
    required this.pakar,
    required this.pesan,
  });

  factory PengajuanPakarModel.fromJson(Map<String, dynamic> json) {
    return PengajuanPakarModel(
      id: json["id"],
      pakar: PakarModel.fromJson(json["pakar"]),
      pesan: json["pesan"],
    );
  }
}
