class PenjualModel {
  final String id;
  final String namaToko;
  final String idKecamatanToko;

  PenjualModel({
    required this.id,
    required this.namaToko,
    required this.idKecamatanToko,
  });

  factory PenjualModel.fromJson(Map<String, dynamic> json) {
    return PenjualModel(
      id: json["id"],
      namaToko: json["namaToko"],
      idKecamatanToko: json["idKecamatanToko"],
    );
  }
}
