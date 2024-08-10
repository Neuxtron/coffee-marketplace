import 'package:coffee_marketplace/models/pengajuan_pakar_model.dart';
import 'package:coffee_marketplace/views/_admin/admin_home/approve_modal.dart';
import 'package:flutter/material.dart';

class PengajuanItem extends StatelessWidget {
  final PengajuanPakarModel pengajuan;
  const PengajuanItem({super.key, required this.pengajuan});

  static late BuildContext context;

  void requestApprove() {
    showDialog(
      context: context,
      builder: (context) {
        return ApproveModal(pengajuan: pengajuan);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    PengajuanItem.context = context;

    return Container(
      clipBehavior: Clip.hardEdge,
      height: 100,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.07),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pengajuan.pakar.nama,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    pengajuan.pesan,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 100,
            child: VerticalDivider(
              color: Colors.black12,
              indent: 20,
              endIndent: 20,
              width: 1,
            ),
          ),
          Material(
            color: Colors.blue.withOpacity(.05),
            child: InkWell(
              onTap: requestApprove,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Approve",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
