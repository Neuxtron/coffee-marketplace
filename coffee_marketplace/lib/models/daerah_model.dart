class DaerahModel {
  final String id;
  final String nama;

  DaerahModel({
    required this.id,
    required this.nama,
  });
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
