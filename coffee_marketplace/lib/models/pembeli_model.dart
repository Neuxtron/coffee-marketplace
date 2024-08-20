class PembeliModel {
  final String id;
  final String nama;

  PembeliModel({
    required this.id,
    required this.nama,
  });

  factory PembeliModel.fromJson(Map<String, dynamic> json) {
    return PembeliModel(
      id: json["id"],
      nama: json["nama"],
    );
  }
}
