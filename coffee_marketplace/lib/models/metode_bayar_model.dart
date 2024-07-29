class MetodeBayarModel {
  final String id;
  final String nama;
  final String imgUrl;
  // TODO: pembayaran kategori

  MetodeBayarModel({
    required this.id,
    required this.nama,
    required this.imgUrl,
  });
}

final dummyMetodeBayar = [
  MetodeBayarModel(
    id: "bca",
    nama: "BCA",
    imgUrl:
        "https://i.pinimg.com/736x/8c/14/00/8c14002029a523a0cbaf65dd59306a43.jpg",
  ),
  MetodeBayarModel(
    id: "bni",
    nama: "BNI",
    imgUrl:
        "https://logowik.com/content/uploads/images/bni-bank-negara-indonesia8078.logowik.com.webp",
  ),
  MetodeBayarModel(
    id: "bri",
    nama: "BRI",
    imgUrl:
        "https://i.pinimg.com/originals/26/b1/d5/26b1d5503605789d2cbd551704f5c948.jpg",
  ),
];
