class RiwayatPengirimanModel {
  final String deskripsi;
  final DateTime tanggal;

  RiwayatPengirimanModel({
    required this.deskripsi,
    required this.tanggal,
  });

  factory RiwayatPengirimanModel.fromJson(Map<String, dynamic> json) {
    return RiwayatPengirimanModel(
      deskripsi: json["desc"],
      tanggal: DateTime.parse(json["date"]),
    );
  }
}
