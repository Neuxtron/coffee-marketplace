class VariasiModel {
  final String? id;
  final String nama;
  final int stok;

  VariasiModel({
    required this.id,
    required this.nama,
    required this.stok,
  });

  factory VariasiModel.fromJson(Map<String, dynamic> json) {
    return VariasiModel(
      id: json["id"],
      nama: json["nama"],
      stok: json["stok"],
    );
  }

  static List<Map<String, dynamic>> toMap(List<VariasiModel> listVariasi) {
    List<Map<String, dynamic>> listMap = [];
    for (var variasi in listVariasi) {
      listMap.add({
        "id": variasi.id,
        "nama": variasi.nama,
        "stok": variasi.stok,
      });
    }

    return listMap;
  }
}
