import 'package:coffee_marketplace/viewmodels/keranjang_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCheckbox extends StatefulWidget {
  final String id;
  const ItemCheckbox({super.key, required this.id});

  @override
  State<ItemCheckbox> createState() => _ItemCheckboxState();
}

class _ItemCheckboxState extends State<ItemCheckbox> {
  KeranjangViewModel get _viewModel => context.read<KeranjangViewModel>();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _isChecked,
      onChanged: (value) {
        setState(() => _isChecked = !_isChecked);
        _viewModel.setChecked(widget.id, _isChecked);
      },
    );
  }
}
