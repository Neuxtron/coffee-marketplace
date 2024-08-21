class AlamatModel {
  final String? id;
  final String idKecamatan;
  final String alamat;

  AlamatModel({
    this.id,
    required this.idKecamatan,
    required this.alamat,
  });

  factory AlamatModel.fromJson(Map<String, dynamic> json) {
    return AlamatModel(
      id: json["id"],
      idKecamatan: json["idKecamatan"],
      alamat: json["alamat"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "idKecamatan": idKecamatan,
      "alamat": alamat,
    };
  }
}
