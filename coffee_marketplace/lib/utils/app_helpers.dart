import 'package:intl/intl.dart';

class AppHelpers {
  static String? token;

  static formatHarga(int harga) {
    final hargaString = NumberFormat("Rp ###,###,###").format(harga);
    return hargaString;
  }

  static formatTanggal(DateTime tanggal) {
    final tanggalString = DateFormat("dd-MM-yyyy").format(tanggal);
    return tanggalString;
  }
}
