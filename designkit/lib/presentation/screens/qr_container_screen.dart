import 'package:flutter/material.dart';
import '../../components/molecules/qr_login.dart';

class QrLoginScreen extends StatelessWidget {
  const QrLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF7289C0),
      body: Center(
        child: QrLogin(
          title: "Click to scan QR and login",
          subtitle: "New HDFC Bank Early Access App Required",
          popupTitle: "Scan to Login",
          qrData: "https://example.com/login",
        ),
      ),
    );
  }
}
