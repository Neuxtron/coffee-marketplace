class KategoriModel {
  final String id;
  final String icon;
  final String nama;

  KategoriModel({
    required this.id,
    required this.icon,
    required this.nama,
  });
}

final List<KategoriModel> dummyKategori = [
  KategoriModel(id: "1", icon: "assets/icons/ic_coffee.svg", nama: "Coffee"),
  KategoriModel(id: "2", icon: "assets/icons/ic_coffee.svg", nama: "Coffee"),
  KategoriModel(id: "3", icon: "assets/icons/ic_coffee.svg", nama: "Coffee"),
];
