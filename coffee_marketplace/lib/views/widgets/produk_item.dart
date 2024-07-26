import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/models/produk_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:coffee_marketplace/views/widgets/error_image.dart';
import 'package:coffee_marketplace/views/widgets/loading_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProdukItem extends StatelessWidget {
  final double shadowSize;
  final ProdukModel produk;

  const ProdukItem({
    super.key,
    required this.shadowSize,
    required this.produk,
  });

  static late BuildContext _context;

  void addToCart() {
    final keranjang = KeranjangModel(
      produk: produk,
      variasi: produk.variasi[0],
    );
    _context
        .read<KeranjangViewModel>()
        .updateKeranjang(keranjang: keranjang)
        .then((_) {
      Fluttertoast.showToast(msg: "Berhasil dimasukkan ke keranjang");
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    final hargaString = AppHelpers.formatHarga(produk.harga);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/details", arguments: produk);
      },
      child: Center(
        child: Stack(
          children: [
            Container(
              height: shadowSize,
              width: shadowSize,
              margin: const EdgeInsets.fromLTRB(5, 40, 5, 0),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppConstants.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          produk.nama,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          hargaString,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: addToCart,
                    icon: SvgPicture.asset(
                      "assets/icons/ic_keranjang.svg",
                      height: 20,
                      width: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: shadowSize + 10,
              child: Align(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    produk.thumbnail,
                    height: 120,
                    width: 120,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const LoadingImage(
                        height: 120,
                        width: 120,
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const ErrorImage(
                        height: 120,
                        width: 120,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
