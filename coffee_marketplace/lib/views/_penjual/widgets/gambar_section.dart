import 'dart:developer';
import 'dart:io';

import 'package:coffee_marketplace/views/_penjual/widgets/gambar_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class GambarSection extends StatefulWidget {
  final Function(File gambar) onChange;
  const GambarSection({super.key, required this.onChange});

  @override
  State<GambarSection> createState() => _GambarSectionState();
}

class _GambarSectionState extends State<GambarSection> {
  final _imagePicker = ImagePicker();
  File? _gambar;

  Future pickImage() async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => _gambar = imageTemp);
      widget.onChange(imageTemp);
    } on PlatformException catch (e) {
      log(e.toString());
      Fluttertoast.showToast(
        msg: "Terjadi kesalahan",
        backgroundColor: Colors.black54,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_gambar != null) {
      return GambarPreview(
        gambar: _gambar!,
        pickImage: pickImage,
      );
    }

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.grey.shade400.withOpacity(.5),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: pickImage,
          overlayColor: const WidgetStatePropertyAll(Colors.white24),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Icon(
                Icons.add_photo_alternate_outlined,
                color: Colors.grey.shade600,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
