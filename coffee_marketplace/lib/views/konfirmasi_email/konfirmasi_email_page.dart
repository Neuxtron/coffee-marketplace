import 'package:coffee_marketplace/utils/app_constants.dart';
import 'package:coffee_marketplace/viewmodels/user_view_model.dart';
import 'package:coffee_marketplace/views/widgets/info_builder.dart';
import 'package:coffee_marketplace/views/widgets/input_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class KonfirmasiEmailPage extends StatefulWidget {
  const KonfirmasiEmailPage({super.key});

  @override
  State<KonfirmasiEmailPage> createState() => _KonfirmasiEmailPageState();
}

class _KonfirmasiEmailPageState extends State<KonfirmasiEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final _kodeController = TextEditingController();

  bool _isRequesting = true;
  bool _requested = false;
  bool _isSubmitting = false;
  String? _error;

  void _sendRequest() {
    if (!_isRequesting) setState(() => _isRequesting = true);
    context
        .read<UserViewModel>()
        .requestKonfirmasiEmail()
        .then(_postSendRequest);
  }

  void _postSendRequest(bool success) {
    setState(() {
      _isRequesting = false;
      _requested = success;
    });
  }

  void _konfirmasiEmail() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isSubmitting = true);

    final kode = _kodeController.text.trim();
    context
        .read<UserViewModel>()
        .konfirmasiEmail(kode)
        .then(_postKonfirmasiEmail);
  }

  void _postKonfirmasiEmail(String? error) {
    if (error == null) {
      Fluttertoast.showToast(
        msg: "Email berhasil dikonfirmasi",
        backgroundColor: Colors.black54,
      );
      Navigator.pop(context);
      return;
    }

    setState(() {
      _isSubmitting = false;
      _error = error;
    });
  }

  @override
  void initState() {
    super.initState();
    _sendRequest();
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.background,
      title: const Text(
        "Konfirmasi Email",
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

  Scaffold _buildPageWrapper({required Widget child}) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isRequesting) {
      return _buildPageWrapper(
        child: const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }

    if (!_requested) {
      return _buildPageWrapper(
        child: Align(
          alignment: Alignment.topCenter,
          child: InfoBuilder(
            onPressed: _sendRequest,
            iconData: Icons.error_outline,
          ),
        ),
      );
    }

    final email = context.read<UserViewModel>().currentUser!.email;

    return _buildPageWrapper(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: InputItem(
                  label:
                      "Masukkan kode konfirmasi yang telah dikirim ke $email:",
                  errorText: "Kode tidak boleh kosong",
                  controller: _kodeController,
                  keyboardType: TextInputType.number,
                ),
              ),
              Center(
                child: Text(
                  _error ?? "",
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              MaterialButton(
                onPressed: _isSubmitting ? null : _konfirmasiEmail,
                color: AppConstants.primary,
                padding: const EdgeInsets.symmetric(vertical: 7),
                disabledColor: AppConstants.primary.withOpacity(.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                minWidth: double.infinity,
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontFamily: "Abhaya Libre",
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
