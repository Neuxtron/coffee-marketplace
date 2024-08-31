import 'package:coffee_marketplace/models/keranjang_model.dart';
import 'package:coffee_marketplace/models/order_model.dart';
import 'package:coffee_marketplace/models/riwayat_pengiriman_model.dart';
import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/utils/app_helpers.dart';
import 'package:coffee_marketplace/viewmodels/order_view_model.dart';
import 'package:coffee_marketplace/views/widgets/info_builder.dart';
import 'package:coffee_marketplace/views/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailRiwayatPage extends StatelessWidget {
  const DetailRiwayatPage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Detail Pembelian",
        style: TextStyle(
          fontFamily: "Abhaya Libre",
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderModel;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _DetailPembelian(order: order),
            const _SectionDivider(),
            _KeranjangListView(listKeranjang: order.keranjang),
            const _SectionDivider(),
            _RiwayatTracking(idOrder: order.id),
          ],
        ),
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 10,
      thickness: 1,
      color: Colors.black26,
    );
  }
}

class _DetailPembelian extends StatelessWidget {
  final OrderModel order;
  const _DetailPembelian({required this.order});

  @override
  Widget build(BuildContext context) {
    final ongkirString = AppHelpers.formatHarga(order.ongkir);

    int subtotal = 0;
    for (var keranjang in order.keranjang) {
      subtotal += keranjang.produk.harga * keranjang.amount;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: SvgPicture.asset("assets/icons/ic_detail.svg"),
            ),
            const Text(
              "Detail Pembelian",
              style: TextStyle(
                fontFamily: "Abhaya Libre",
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 120),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildDetailItem(
                label: "Subtotal Produk",
                value: subtotal.toString(),
              ),
              _buildDetailItem(
                label: "Ongkir",
                value: ongkirString,
              ),
              _buildDetailItem(
                label: "Status",
                value: order.statusMessage,
              ),
              _buildDetailItem(
                label: "Resi Pengiriman",
                value: order.resiPengiriman!,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildDetailItem({required String label, required String value}) {
    const textStyle = TextStyle(
      fontFamily: "Abhaya Libre",
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
        ),
        Text(value)
      ],
    );
  }
}

class _KeranjangItem extends StatelessWidget {
  final KeranjangModel keranjang;
  const _KeranjangItem({required this.keranjang});

  @override
  Widget build(BuildContext context) {
    final produk = keranjang.produk;
    final hargaString = AppHelpers.formatHarga(produk.harga);

    return Stack(
      children: [
        Row(
          children: [
            RoundedImage(
              imageUrl: produk.thumbnail,
              height: 75,
              width: 75,
              radius: 10,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.nama,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: "Abhaya Libre",
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    hargaString,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: "Abhaya Libre",
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Text(
            "x${keranjang.amount}",
          ),
        ),
      ],
    );
  }
}

class _KeranjangListView extends StatelessWidget {
  final List<KeranjangModel> listKeranjang;
  const _KeranjangListView({required this.listKeranjang});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listKeranjang.length,
      itemBuilder: (context, index) {
        final keranjang = listKeranjang[index];
        return _KeranjangItem(keranjang: keranjang);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 15),
    );
  }
}

class _RiwayatTracking extends StatefulWidget {
  final String idOrder;
  const _RiwayatTracking({required this.idOrder});

  @override
  State<_RiwayatTracking> createState() => _RiwayatTrackingState();
}

class _RiwayatTrackingState extends State<_RiwayatTracking> {
  @override
  Widget build(BuildContext context) {
    final getData = context.read<OrderViewModel>().getRiwayatPengiriman;

    return FutureBuilder(
      future: getData(widget.idOrder),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Align(
            alignment: Alignment.topCenter,
            child: InfoBuilder(
              onPressed: () => setState(() {}),
              iconData: Icons.error_outline,
            ),
          );
        }

        final listKeranjang = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listKeranjang.length,
          itemBuilder: (context, index) {
            final riwayat = listKeranjang[index];
            return _RiwayatItem(
              riwayat: riwayat,
              isActive: index == 0,
            );
          },
        );
      },
    );
  }
}

class _RiwayatItem extends StatelessWidget {
  final RiwayatPengirimanModel riwayat;
  final bool isActive;

  const _RiwayatItem({
    required this.riwayat,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd MMM\nHH.mm");
    final tanggalString = formatter.format(riwayat.tanggal);
    final color = isActive ? Colors.blue.shade800 : Colors.grey;
    final textStyle = TextStyle(color: color, fontSize: 12);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tanggalString,
            textAlign: TextAlign.right,
            style: textStyle,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Icon(
              Icons.circle,
              size: 10,
              color: color,
            ),
          ),
          Expanded(
            child: Text(
              riwayat.deskripsi,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
