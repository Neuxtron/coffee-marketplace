import 'dart:io';

import 'package:flutter/material.dart';

class GambarPreview extends StatefulWidget {
  final File gambar;
  final Function() pickImage;

  const GambarPreview({
    super.key,
    required this.gambar,
    required this.pickImage,
  });

  @override
  State<GambarPreview> createState() => _GambarPreviewState();
}

class _GambarPreviewState extends State<GambarPreview> {
  bool _showEdit = false;

  void onPressed(_) async {
    if (_showEdit) await widget.pickImage();
    setState(() => _showEdit = !_showEdit);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Image.file(
            widget.gambar,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          Opacity(
            opacity: _showEdit ? 1 : 0,
            child: TapRegion(
              onTapInside: onPressed,
              onTapOutside: (_) => setState(() => _showEdit = false),
              child: Container(
                height: 200,
                width: 200,
                color: Colors.black54,
                child: Center(
                  child: Icon(
                    Icons.photo_library,
                    color: Colors.white,
                    size: 40,
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
