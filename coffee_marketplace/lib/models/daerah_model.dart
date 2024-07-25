class DaerahModel {
  final String id;
  final String nama;

  DaerahModel({
    required this.id,
    required this.nama,
  });

  factory DaerahModel.fromProvinsiJson(Map<String, dynamic> json) {
    return DaerahModel(
      id: json["province_id"],
      nama: json["province"],
    );
  }
  factory DaerahModel.fromKecamatanJson(Map<String, dynamic> json) {
    return DaerahModel(
      id: json["city_id"],
      nama: json["city_name"],
    );
  }
}

final dummyProvinsi = [
  DaerahModel(id: "1", nama: "Provinsi 1"),
  DaerahModel(id: "2", nama: "Provinsi 2"),
  DaerahModel(id: "3", nama: "Provinsi 3"),
];

final dummyKecamatan = [
  DaerahModel(id: "1", nama: "Kecamatan 1"),
  DaerahModel(id: "2", nama: "Kecamatan 2"),
  DaerahModel(id: "3", nama: "Kecamatan 3"),
];
