// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/screens/helper.dart';
import 'package:kp_project/screens/receiving/receiving_input_screen.dart';
import 'package:kp_project/widgets/my_card.dart';
import 'package:kp_project/widgets/my_icon_button.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ReceivingScreen extends StatefulWidget {
  const ReceivingScreen({super.key});

  @override
  State<ReceivingScreen> createState() => _ReceivingScreenState();
}

class _ReceivingScreenState extends State<ReceivingScreen> {
  void scanQR() async {
    String qrcodeScanRes;
    try {
      qrcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        false,
        ScanMode.QR,
      );

      if (qrcodeScanRes.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ReceivingInputScreen(containerNumber: qrcodeScanRes),
          ),
        );
      } else {
        showErrorMessage(context, "Scanning QR code canceled");
      }
    } on PlatformException {
      showErrorMessage(context, "Failed to get platform version !");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: silver,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            //Card View
            const MyCard(
              title: "Receiving",
              description:
                  "Proses penerimaan kontainer dimana pada proses ini mencakup pemeriksaan fisik dan pencatatan informasi dari kontainer yang masuk.",
            ),

            const SizedBox(
              height: 100,
            ),

            Column(
              children: [
                MyIconButton(
                  icon: Icons.qr_code_scanner_rounded,
                  text: "Scan QR",
                  onPressed: scanQR,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyIconButton(
                  icon: Icons.keyboard,
                  text: "Manual Input",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ReceivingInputScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
