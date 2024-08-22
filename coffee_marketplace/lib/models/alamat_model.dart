class AlamatModel {
  final String? id;
  final String idKecamatan;
  final String idProvinsi;
  final String alamat;

  AlamatModel({
    this.id,
    required this.idKecamatan,
    required this.idProvinsi,
    required this.alamat,
  });

  factory AlamatModel.fromJson(Map<String, dynamic> json) {
    return AlamatModel(
      id: json["id"],
      idKecamatan: json["idKecamatan"],
      idProvinsi: json["idProvinsi"],
      alamat: json["alamat"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "idKecamatan": idKecamatan,
      "idProvinsi": idProvinsi,
      "alamat": alamat,
    };
  }
}
